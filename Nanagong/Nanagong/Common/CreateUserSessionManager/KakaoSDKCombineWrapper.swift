//
//  KakaoSDKCombineWrapper.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/11.
//

import Combine
import Foundation
import KakaoSDKUser
import KakaoSDKAuth

final class KakaoSDKCombineWrapper {
    
    private let loginResultPublisher: PassthroughSubject<OAuthToken, KakaoSessionManagerError> = .init()
    
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
