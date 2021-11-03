//
//  OnBoardingViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import UIKit

final class OnBoardingViewCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let dependecy: SlothAppDependencyContainer
    private let onBoardingViewControllerFactory: OnBoardingViewControllerFactory
    private var onBoardingViewController: OnBoardingViewController?
    
    private var signInViewCoordinator: SignInViewCoordinator?
    private var privacyPolicyViewCoordinator: PrivacyPolicyViewCoordinator?
    
    init(presenter: UINavigationController, dependecy: SlothAppDependencyContainer) {
        self.presenter = presenter
        self.dependecy = dependecy
        self.onBoardingViewControllerFactory = .init(dependecy: dependecy)
    }

    func start() {
        let onBoardingViewController = onBoardingViewControllerFactory.makeOnBoardingViewController(with: self)
        self.onBoardingViewController = onBoardingViewController
        
        presenter.viewControllers = [onBoardingViewController]
    }
    
    func present(with state: OnBoardingViewModel.OnBoardingViewState) {
        switch state {
        case .signIn:
            self.signInViewCoordinator = makeSignInViewCoordinator()
            signInViewCoordinator?.start()
            
        case .privacy:
            self.privacyPolicyViewCoordinator = makePrivacyPolicyViewCoordinator()
            privacyPolicyViewCoordinator?.start()
            
        default:
            break
        }
    }
    
    private func makeSignInViewCoordinator() -> SignInViewCoordinator {
        return .init(presenter: onBoardingViewController,
                     signInViewControllerFactory: onBoardingViewControllerFactory.makeSignInViewControllerFactory())
    }
    
    private func makePrivacyPolicyViewCoordinator() -> PrivacyPolicyViewCoordinator {
        return .init(presenter: onBoardingViewController)
    }
}
