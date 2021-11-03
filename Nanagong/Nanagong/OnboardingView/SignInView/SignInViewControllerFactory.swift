//
//  SignInViewControllerFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import UIKit

final class SignInViewControllerFactory {
    
    private unowned var parentViewModel: OnBoardingViewModel
    private unowned var dependency: SlothAppDependencyContainer
    
    init(dependency: SlothAppDependencyContainer, parentViewModel: OnBoardingViewModel) {
        self.dependency = dependency
        self.parentViewModel = parentViewModel
    }
    
    func makeSignInViewController() -> SignInViewController {
        return .init(signInViewModel: makeSignInViewModel())
    }
    
    private func makeSignInViewModel() -> SignInViewModel {
        return .init(signInRepository: makeSignInRepository(),
                     keyChainManager: dependency.keyChainManager,
                     onBoardingViewModel: parentViewModel)
    }
    
    private func makeSignInRepository() -> SignInRepository {
        return .init(appleSessionManager: dependency.appleSessionManager,
                     googleSessionManager: dependency.googleSessionManager,
                     kakaoSessionManager: dependency.kakaoSessionManager,
                     networkManager: dependency.networkManager)
    }
}
