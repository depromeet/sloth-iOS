//
//  OnBoardingViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import UIKit

final class OnBoardingViewCoordinator: Coordinator {
    
    let onBoardingViewController: UIViewController = .init()
    private let presenter: UINavigationController
    private let dependecy: SlothAppDependencyContainer
    private let onBoardingViewControllerFactory: OnBoardingViewControllerFactory
    
    init(presenter: UINavigationController, dependecy: SlothAppDependencyContainer) {
        self.presenter = presenter
        self.dependecy = dependecy
        self.onBoardingViewControllerFactory = .init(dependecy: dependecy)
    }

    func start() {
        let onBoardingViewController = onBoardingViewControllerFactory.makeOnBoardingViewController()
        presenter.viewControllers = [onBoardingViewController]
    }
}
