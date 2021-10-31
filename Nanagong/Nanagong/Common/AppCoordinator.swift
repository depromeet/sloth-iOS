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
    private let registerLessonInformationViewCoordinator: RegisterLessonInformationViewCoordinator
    
    init(window: UIWindow?) {
        self.window = window
        let root = UIViewController()
        root.view.backgroundColor = .blue
        self.dependencyContainer = .init(window: window)
        self.rootViewController = UINavigationController(rootViewController: root)
        self.registerLessonInformationViewCoordinator = .init(presenter: rootViewController, viewContorllersFactory: .init(appDependency: dependencyContainer))
    }
    
    func start() {
        window?.rootViewController = rootViewController
        window?.overrideUserInterfaceStyle = .light
        registerLessonInformationViewCoordinator.start()
        window?.makeKeyAndVisible()
    }
}
