//
//  AppDelegate.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var injectionContainer = SlothAppDependencyContainer(window: window)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let onBoardingViewController = injectionContainer.createOnBoardingDependencyContainer()
        let rootViewController = onBoardingViewController.createOnboardingViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
//        window?.rootViewController = rootViewController
//        let registerLessonViewDependencyContainer = RegisterLessonViewDependencyContainer(appDependency: injectionContainer)
//        let navigationController = UINavigationController(rootViewController: registerLessonViewDependencyContainer.makeRegisterLessonViewController())
        window?.rootViewController = rootViewController
        
        setUpKakaoSDK()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if injectionContainer.kakaoSessionManager.isKakaoTalkSignInUrl(url) {
            return injectionContainer.kakaoSessionManager.handleOpenUrl(url)
        }
        
        if injectionContainer.googleSessionManager.handleOpenURL(url) {
            return true
        }

        return false
    }
    
    private func setUpKakaoSDK() {
        injectionContainer.kakaoSessionManager.initSDK()
    }
}
