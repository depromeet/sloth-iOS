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
    
    private lazy var appCoordinator: AppCoordinator = .init(window: window)
    private lazy var appDependencyContainer: SlothAppDependencyContainer = .init(window: window)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator.start()
        setUpKakaoSDK()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if appDependencyContainer.kakaoSessionManager.isKakaoTalkSignInUrl(url) {
            return appDependencyContainer.kakaoSessionManager.handleOpenUrl(url)
        }
        
        if appDependencyContainer.googleSessionManager.handleOpenURL(url) {
            return true
        }

        return false
    }
    
    private func setUpKakaoSDK() {
        appDependencyContainer.kakaoSessionManager.initSDK()
    }
}
