//
//  SignInRepository.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/15.
//

import AuthenticationServices
import Combine
import Foundation
import GoogleSignIn
import KakaoSDKAuth
import SlothNetworkModule

enum SignInRepositoryError: Error {
    
    case kakaoError(error: KakaoSessionManagerError)
    case googleError(error: GoogleSessionManagerError)
    case networkError(error: NetworkError)
    case decodeError
    case extra
}

final class SignInRepository {
    
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
    
    func signInWithGoogle(presentViewController: UIViewController) -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> {
        return googleSessionManager.signIn(presentViewController: presentViewController)
            .mapError { error -> SignInRepositoryError in
                return .googleError(error: error)
            }
            .flatMap { [weak self] idToken -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> in
                guard let self = self else {
                    return Fail(error: SignInRepositoryError.extra).eraseToAnyPublisher()
                }
                
                return self.retrieveClientToken(with: idToken, socialSignInType: .google)
            }.eraseToAnyPublisher()
    }
    
    func signInWithKakao() -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> {
        return kakaoSessionManager.signInWithKakao()
            .mapError { error -> SignInRepositoryError in
                return .kakaoError(error: error)
            }
            .flatMap { [weak self] token -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> in
                guard let self = self else {
                    return Fail(error: SignInRepositoryError.extra).eraseToAnyPublisher()
                }
                
                return self.retrieveClientToken(with: token.accessToken, socialSignInType: .kakao)
            }.eraseToAnyPublisher()
    }
    
    private func retrieveClientToken(with socialSignInToken: String, socialSignInType: SocialSignInType) -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> {
        return networkManager.dataTaskPublisher(for: EndPoint(urlInformation: .signIn).url, httpMethod: .post(body: SocialSignInBody(socialSignInType: socialSignInType)), httpHeaders: ["Authorization": socialSignInToken])
            .decode(type: SocialSignInResponse.self, decoder: JSONDecoder())
            .mapError { error -> SignInRepositoryError in
                if error is DecodingError {
                    return .decodeError
                } else if let error = error as? NetworkError {
                    return .networkError(error: error)
                } else {
                    return .extra
                }
            }
            .eraseToAnyPublisher()
    }
}
