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
    private let signInResultPublisher: PassthroughSubject<IDToken, GoogleSessionManagerError> = .init()
    
    func makeConfiguration() -> GIDConfiguration {
        let appID = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_CLIENTID") as? String ?? ""
        let signInfConfig = GIDConfiguration.init(clientID: appID)
        
        return signInfConfig
    }
    
    func handleOpenURL(_ url: URL) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func signIn(presentViewController: UIViewController) -> AnyPublisher<IDToken, GoogleSessionManagerError> {
        let config = makeConfiguration()
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentViewController) { [weak self] user, error in
            if let error = error {
                self?.signInResultPublisher.send(completion: .failure(.googleSignInError(error)))
            } else if let user = user {
                self?.fetchToken(user: user)
            }
        }
        
        return signInResultPublisher.eraseToAnyPublisher()
    }
    
    private func fetchToken(user: GIDGoogleUser) {
        user.authentication.do { [weak self] authentication, error in
            if let error = error {
                self?.signInResultPublisher.send(completion: .failure(.googleSignInError(error)))
            } else if let authenticaton = authentication, let token = authenticaton.idToken {
                self?.signInResultPublisher.send(token)
            }
        }
    }
}
