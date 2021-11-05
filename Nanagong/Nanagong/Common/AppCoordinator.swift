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
    private let rootViewController: UINavigationController
    private let onboardingViewCoordinator: OnBoardingViewCoordinator
    
    init(window: UIWindow?) {
        self.window = window
        self.dependencyContainer = .init(window: window, keyChainManager: KeyChainWrapperManager())
        self.rootViewController = UINavigationController()
        self.onboardingViewCoordinator = .init(presenter: rootViewController, dependecy: dependencyContainer)
    }
    
    func start() {
        window?.rootViewController = rootViewController
        window?.overrideUserInterfaceStyle = .light
        onboardingViewCoordinator.start()
        window?.makeKeyAndVisible()
    }
}
