//
//  SlothAppDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/11.
//

import UIKit
import SlothNetworkModule

final class SlothAppDependencyContainer {
    
    let kakaoSessionManager: KakaoSessionManager = .init()
    let googleSessionManager: GoogleSessiongManager = .init()
    private let networkManager: NetworkManager = .init(requester: SlothNetworkModule.NetworkManager())
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func createOnboardingViewController() -> OnBoardingViewController {
        return OnBoardingViewController(onboardingViewModel: createOnboardingViewModel())
    }
    
    private func createOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel(signInRepository: createSignInRepository())
    }
    
    private func createSignInRepository() -> SignInRepository {
        return SignInRepository(appleSessionManager: createAppleSessionManager(),
                                googleSessionManager: googleSessionManager,
                                kakaoSessionManager: kakaoSessionManager,
                                networkManager: networkManager)
    }
    
    private func createAppleSessionManager() -> AppleSessionMananger {
        return AppleSessionMananger(window: window)
    }
}
