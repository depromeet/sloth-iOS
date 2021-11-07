//
//  SignedInTabBarCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import UIKit

final class SignedInTabBarCoordinator: Coordinator {

    private unowned var parentCoordinator: AppCoordinator
    private unowned var presenter: UIViewController
    private unowned var dependecy: SlothAppDependencyContainer
    private let viewController: SignedInTabBarController
    
    init(parentCoordinator: AppCoordinator, presenter: UIViewController, dependecy: SlothAppDependencyContainer) {
        self.parentCoordinator = parentCoordinator
        self.presenter = presenter
        self.dependecy = dependecy
        self.viewController = SignedInTabBarController()
    }
    
    func start() {
        presenter.addFullScreen(childViewController: viewController)
    }
}
