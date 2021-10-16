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
    
    private let signInRepository: SignInRepository
    
    init(signInRepository: SignInRepository) {
        self.signInRepository = signInRepository
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
}
