//
//  OnboardingViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/15.
//

import AuthenticationServices
import Combine
import Foundation
import GoogleSignIn
import KakaoSDKAuth

final class OnboardingViewModel {
    
    private let appleSessionManager: AppleSessionMananger
    private let googleSessionManager: GoogleSessiongManager
    private let kakaoSessionManager: KakaoSessionManager
    private let networkManager: NetworkManager
    
    init(appleSessionManager: AppleSessionMananger,
         googleSessionManager: GoogleSessiongManager,
         kakaoSessionManager: KakaoSessionManager,
         networkManager: NetworkManager) {
        self.appleSessionManager = appleSessionManager
        self.googleSessionManager = googleSessionManager
        self.kakaoSessionManager = kakaoSessionManager
        self.networkManager = networkManager
    }
    
    func signInWithApple() -> AnyPublisher<ASAuthorizationAppleIDCredential, Error> {
        return appleSessionManager.signIn()
    }
    
    func signInWithGoogle(presentViewController: UIViewController) -> AnyPublisher<GoogleSessiongManager.IDToken, GoogleSessionManagerError> {
        return googleSessionManager.signIn(presentViewController: presentViewController)
    }
    
    func signInWithKakao() -> AnyPublisher<OAuthToken, KakaoSessionManagerError> {
        return kakaoSessionManager.loginWithKakao()
    }
}
