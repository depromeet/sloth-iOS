//
//  OnBoardingDependencyContainer.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/30.
//

import Foundation

final class OnBoardingDependencyContainer {
    
    private unowned var dependency: SlothAppDependencyContainer
    
    init(dependency: SlothAppDependencyContainer) {
        self.dependency = dependency
    }
    
    func makeOnBoardingViewModel() -> OnBoardingViewModel {
        return OnBoardingViewModel.init(keyChainManager: dependency.keyChainManager)
    }
    
    func makeSignInViewController(onBoardingViewModel: OnBoardingViewModel) -> SignInViewController {
        let signInViewModel = makeSignInViewModel(onBoardingViewModel: onBoardingViewModel)
        return SignInViewController(signInViewModel: signInViewModel)
    }
    
    private func makeSignInViewModel(onBoardingViewModel: OnBoardingViewModel) -> SignInViewModel {
        return SignInViewModel(signInRepository: makeSignInRepository(),
                               keyChainManager: dependency.keyChainManager,
                               onBoardingViewModel: onBoardingViewModel)
    }
    
    private func makeSignInRepository() -> SignInRepository {
        return SignInRepository(appleSessionManager: dependency.appleSessionManager,
                                googleSessionManager: dependency.googleSessionManager,
                                kakaoSessionManager: dependency.kakaoSessionManager,
                                networkManager: dependency.networkManager)
    }
}
