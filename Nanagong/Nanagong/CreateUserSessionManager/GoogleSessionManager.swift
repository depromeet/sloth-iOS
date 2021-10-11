//
//  GoogleSessionManager.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/11.
//

import Foundation
import Combine

import GoogleSignIn

enum GoogleSessionManagerError: Error {
    
    case googleSignInError(_: Error)
    case unknownError
}

final class GoogleSessiongManager {
    
    typealias IDToken = String
    private let signInResultPublisher: PassthroughSubject<GIDGoogleUser, GoogleSessionManagerError> = .init()
    private let fetchTokenPublisher: PassthroughSubject<IDToken, GoogleSessionManagerError> = .init()
    
    func makeConfiguration() -> GIDConfiguration {
        let appID = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_CLIENTID") as? String ?? ""
        let signInfConfig = GIDConfiguration.init(clientID: appID)
        
        return signInfConfig
    }
    
    func handleOpenURL(_ url: URL) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func signIn(presentViewController: UIViewController) -> AnyPublisher<GIDGoogleUser, GoogleSessionManagerError> {
        let config = makeConfiguration()
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentViewController) { [weak self] user, error in
            if let error = error {
                self?.signInResultPublisher.send(completion: .failure(.googleSignInError(error)))
            } else if let user = user {
                self?.signInResultPublisher.send(user)
                self?.signInResultPublisher.send(completion: .finished)
            }
        }
        
        return signInResultPublisher.eraseToAnyPublisher()
    }
    
    func fetchToken(user: GIDGoogleUser) -> AnyPublisher<IDToken, GoogleSessionManagerError> {
        user.authentication.do { [weak self] authentication, error in
            if let error = error {
                self?.fetchTokenPublisher.send(completion: .failure(.googleSignInError(error)))
            } else if let authenticaton = authentication, let token = authenticaton.idToken {
                self?.fetchTokenPublisher.send(token)
                self?.fetchTokenPublisher.send(completion: .finished)
            }
        }
        
        return fetchTokenPublisher.eraseToAnyPublisher()
    }
}
