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
    let appleSessionManager: AppleSessionMananger
    let networkManager: NetworkManager
    let keyChainManager: KeyChaingWrapperManagable
    
    private let window: UIWindow?
    
    init(window: UIWindow?, keyChainManager: KeyChaingWrapperManagable) {
        self.window = window
        self.keyChainManager = KeyChainWrapperManager.init()
        appleSessionManager = .init(window: window)
        networkManager = .init(requester: SlothNetworkModule.NetworkManager(),
                               keyChainManager: keyChainManager)
    }
}
