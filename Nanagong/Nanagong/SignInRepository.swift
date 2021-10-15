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
    
    func signInWithGoogle(presentViewController: UIViewController) -> AnyPublisher<GoogleSessiongManager.IDToken, GoogleSessionManagerError> {
        return googleSessionManager.signIn(presentViewController: presentViewController)
    }
    
    func signInWithKakao() -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> {
        return kakaoSessionManager.loginWithKakao()
            .mapError { error -> SignInRepositoryError in
                return .kakaoError(error: error)
            }
            .flatMap { [weak self] token -> AnyPublisher<SocialSignInResponse, SignInRepositoryError> in
                guard let self = self else {
                    return Fail(error: SignInRepositoryError.extra).eraseToAnyPublisher()
                }
                
                return self.networkManager.dataTaskPublisher(for: EndPoint(urlInformation: .signIn).url, httpMethod: .post(body: SocialSignInBody(socialSignInType: .kakao)), httpHeaders: ["Authorization": token.accessToken])
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
            }.eraseToAnyPublisher()
    }
}
