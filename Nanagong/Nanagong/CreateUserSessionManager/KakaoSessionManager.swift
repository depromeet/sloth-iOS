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

enum KakaoSessionManagerError: Error {
    
    case kakaoError(_: Error)
    case unknownError
}

final class KakaoSessionManager {
    
    private let combineWrapper: KakaoSDKCombineWrapper = .init()
    
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
    
    func loginWithKakaoTalk() -> AnyPublisher<OAuthToken, KakaoSessionManagerError> {
        return combineWrapper.loginWithKakao()
    }
}
