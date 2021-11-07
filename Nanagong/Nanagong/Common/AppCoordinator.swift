//
//  AppCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/31.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let dependencyContainer: SlothAppDependencyContainer
    private var window: UIWindow?
    private let viewControllerFactory: MainViewControllerFactory
    private lazy var rootViewController: UIViewController = viewControllerFactory.makeMainViewControlelr(self)
    private var onBoardingViewCoordinator: OnBoardingViewCoordinator?
    
    init(window: UIWindow?) {
        self.window = window
        self.dependencyContainer = .init(window: window, keyChainManager: KeyChainWrapperManager())
        self.viewControllerFactory = .init(dependency: dependencyContainer)
    }
    
    func start() {
        window?.rootViewController = rootViewController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
    
    func presentWelcomeView() {
        onBoardingViewCoordinator = makeOnBoardingViewCoordinator()
        onBoardingViewCoordinator?.start()
    }
    
    func presentSignedInView() {
        onBoardingViewCoordinator?.remove()
        onBoardingViewCoordinator = nil
        
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        rootViewController.addFullScreen(childViewController: vc)
    }
    
    private func makeOnBoardingViewCoordinator() -> OnBoardingViewCoordinator {
        return .init(parentCoordinator: self, presenter: rootViewController, dependecy: dependencyContainer)
    }
}
