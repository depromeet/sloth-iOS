//
//  OnBoardingViewControllerFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import UIKit

final class OnBoardingViewControllerFactory {
    
    private unowned var dependency: SlothAppDependencyContainer
    private let viewModel: OnBoardingViewModel
    
    init(dependecy: SlothAppDependencyContainer) {
        self.dependency = dependecy
        self.viewModel = .init(keyChainManager: dependency.keyChainManager)
    }
    
    func makeOnBoardingViewController(with coordinator: OnBoardingViewCoordinator) -> OnBoardingViewController {
        return .init(coordinator: coordinator,
                     viewModel: viewModel)
    }
    
    func makeSignInViewControllerFactory() -> SignInViewControllerFactory {
        return .init(dependency: dependency, parentViewModel: viewModel)
    }
}
