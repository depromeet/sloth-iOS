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
    private let keyChainManager: KeyChaingWrapperManagable = KeyChainWrapperManager.init()
    let networkManager: NetworkManager
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        
        networkManager = .init(requester: SlothNetworkModule.NetworkManager(),
                               keyChainManager: keyChainManager)
    }
    
    func createOnBoardingDependencyContainer() -> OnBoardingDependencyContainer {
        let signInRepository = createSignInRepository()
        return OnBoardingDependencyContainer(signInRepository: signInRepository,
                                             keyChainManager: keyChainManager)
    }
    
    private func createSignInRepository() -> SignInRepository {
        let networkManager = createNetworkManger()
        
        return SignInRepository(appleSessionManager: createAppleSessionManager(),
                                googleSessionManager: googleSessionManager,
                                kakaoSessionManager: kakaoSessionManager,
                                networkManager: networkManager)
    }
    
    private func createAppleSessionManager() -> AppleSessionMananger {
        return AppleSessionMananger(window: window)
    }
    
    private func createNetworkManger() -> NetworkManager {
        return NetworkManager.init(requester: SlothNetworkModule.NetworkManager(),
                                   keyChainManager: keyChainManager)
    }
}
