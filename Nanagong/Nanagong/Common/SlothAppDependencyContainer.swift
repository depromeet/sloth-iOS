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
    let networkManager: NetworkManager
    
    private let window: UIWindow?
    private let keyChainManager: KeyChaingWrapperManagable = KeyChainWrapperManager.init()
    
    init(window: UIWindow?) {
        self.window = window
        networkManager = .init(requester: SlothNetworkModule.NetworkManager(),
                               keyChainManager: keyChainManager)
    }
    
    func createOnBoardingDependencyContainer() -> OnBoardingDependencyContainer {
        return OnBoardingDependencyContainer(signInRepository: createSignInRepository(),
                                             keyChainManager: keyChainManager)
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
