//
//  SlothAppDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/11.
//

import UIKit

final class SlothAppDependencyContainer {
    
    let kakaoSessionManager: KakaoSessionManager = .init()
    let googleSessionManager: GoogleSessiongManager = .init()
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func createOnboardingViewController() -> OnBoardingViewController {
        return OnBoardingViewController(kakaoSessionManager: kakaoSessionManager, googleSessionManager: googleSessionManager,
        appleSessionManager: createAppleSessionManager())
    }
    
    private func createAppleSessionManager() -> AppleSessionMananger {
        return AppleSessionMananger(window: window)
    }
}
