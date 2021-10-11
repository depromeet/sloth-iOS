//
//  SlothAppDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/11.
//

import Foundation

final class SlothAppDependencyContainer {
    
    let kakaoSessionManager: KakaoSessionManager = .init()
    
    func createOnboardingViewController() -> OnBoardingViewController {
        return OnBoardingViewController(kakaoSessionManager: kakaoSessionManager)
    }
}
