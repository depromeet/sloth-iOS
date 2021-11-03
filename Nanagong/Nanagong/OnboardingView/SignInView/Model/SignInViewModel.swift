//
//  SignInViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/15.
//

import AuthenticationServices
import Combine
import Foundation

final class SignInViewModel {
    
    struct State {
        static let empty: Self = .init()
        
        var isSuccess: Bool = false
    }
    
    private let signInRepository: SignInRepository
    private let keyChainManager: KeyChaingWrapperManagable
    @Published var state: State = .empty
    
    init(signInRepository: SignInRepository,
         keyChainManager: KeyChaingWrapperManagable) {
        self.signInRepository = signInRepository
        self.keyChainManager = keyChainManager
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
    
    func loginSuccess() {
        state = State.init(isSuccess: true)
    }
    
    func loginFail() {
        state = State.init(isSuccess: false)
    }
}
