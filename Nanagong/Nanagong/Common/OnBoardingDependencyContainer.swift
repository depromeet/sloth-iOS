//
//  OnBoardingDependencyContainer.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/30.
//

import Foundation

final class OnBoardingDependencyContainer {
    
    private let signInRepository: SignInRepository
    private let keyChainManager: KeyChaingWrapperManagable
    
    init(signInRepository: SignInRepository, keyChainManager: KeyChaingWrapperManagable) {
        self.signInRepository = signInRepository
        self.keyChainManager = keyChainManager
    }
    
    func createOnboardingViewController() -> OnBoardingViewController {
        return OnBoardingViewController(dependencyContainer: self)
    }
    
    func createOnBoardingViewModel() -> OnBoardingViewModel {
        return OnBoardingViewModel.init(keyChainManager: keyChainManager)
    }
    
    func createSignInViewController(onBoardingViewModel: OnBoardingViewModel) -> SignInViewController {
        let signInViewModel = createSignInViewModel(onBoardingViewModel: onBoardingViewModel)
        return SignInViewController(signInViewModel: signInViewModel)
    }
    
    private func createSignInViewModel(onBoardingViewModel: OnBoardingViewModel) -> SignInViewModel {
        return SignInViewModel(signInRepository: signInRepository,
                               keyChainManager: keyChainManager,
                               onBoardingViewModel: onBoardingViewModel)
    }
}
