//
//  SignInViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/15.
//

import AuthenticationServices
import Combine
import Foundation
import GoogleSignIn
import KakaoSDKAuth

final class SignInViewModel {
    
    private let signInRepository: SignInRepository
    private let keyChainManager: KeyChaingWrapperManagable
    private var onBoardingViewModel: OnBoardingViewModel
    
    init(signInRepository: SignInRepository,
         keyChainManager: KeyChaingWrapperManagable,
         onBoardingViewModel: OnBoardingViewModel) {
        self.signInRepository = signInRepository
        self.keyChainManager = keyChainManager
        self.onBoardingViewModel = onBoardingViewModel
    }
    
    func signInWithApple() -> AnyPublisher<ASAuthorizationAppleIDCredential, Error> {
        return signInRepository.signInWithApple()
    }
    
    func signInWithGoogle(presentViewController: UIViewController) -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> {
        return signInRepository.signInWithGoogle(presentViewController: presentViewController)
    }
    
    func signInWithKakao() -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> {
        return signInRepository.signInWithKakao()
    }
    
    func saveSignInCredentialInfo(with response: SocialSignInResponse) {
        keyChainManager.save(response.accessToken, forKey: .accessToken)
        keyChainManager.save(response.accessTokenExpireTime, forKey: .accessTokenExpireTime)
        keyChainManager.save(response.refreshToken, forKey: .refreshToken)
        keyChainManager.save(response.refreshTokenExpireTime, forKey: .refreshTokenExpireTime)
    }
    
    func changeOnBoardingViewState() {
        self.onBoardingViewModel.viewState = .privacy
    }
}
