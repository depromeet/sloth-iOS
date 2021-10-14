//
//  KakaoSessionManager.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/11.
//

import Combine
import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

enum KakaoSessionManagerError: Error {
    
    case kakaoError(_: Error)
    case unknownError
}

final class KakaoSessionManager {
    
    private let loginResultPublisher: PassthroughSubject<OAuthToken, KakaoSessionManagerError> = .init()
    
    func initSDK() {
        let appID = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APPID") as? String ?? ""
        KakaoSDKCommon.initSDK(appKey: appID)
    }
    
    func isKakaoTalkLoginUrl(_ url: URL) -> Bool {
        return AuthApi.isKakaoTalkLoginUrl(url)
    }
    
    func handleOpenUrl(_ url: URL) -> Bool {
        return AuthController.handleOpenUrl(url: url)
    }
    
    func loginWithKakao() -> AnyPublisher<OAuthToken, KakaoSessionManagerError> {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
        
        return loginResultPublisher.eraseToAnyPublisher()
    }
    
    private func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] token, error in
            self?.processLoginResult(with: (token, error))
        }
    }
    
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount {[weak self] token, error in
            self?.processLoginResult(with: (token, error))
        }
    }
    
    private func processLoginResult(with result: (token: OAuthToken?, error: Error?)) {
        if let error = result.error {
            loginResultPublisher.send(completion: .failure(.kakaoError(error)))
        } else if let token = result.token {
            loginResultPublisher.send(token)
            loginResultPublisher.send(completion: .finished)
        } else {
            loginResultPublisher.send(completion: .failure(.unknownError))
        }
    }
}
