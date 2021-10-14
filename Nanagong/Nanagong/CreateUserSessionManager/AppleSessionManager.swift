//
//  AppleSessionManager.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/11.
//

import AuthenticationServices
import Combine
import Foundation

final class AppleSessionMananger: NSObject {
    
    private weak var window: UIWindow?
    private let loginResultPublisher: PassthroughSubject<ASAuthorizationAppleIDCredential, Error> = .init()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func signIn() -> AnyPublisher<ASAuthorizationAppleIDCredential, Error> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        return loginResultPublisher.eraseToAnyPublisher()
    }
}

extension AppleSessionMananger: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            loginResultPublisher.send(appleIDCredential)
            loginResultPublisher.send(completion: .finished)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        loginResultPublisher.send(completion: .failure(error))
    }
}

extension AppleSessionMananger: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return window!
    }
}
