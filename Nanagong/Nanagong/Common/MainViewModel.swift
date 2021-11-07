//
//  MainViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import Combine
import Foundation

final class MainViewModel {
    
    enum State {
        
        case signedOut
        
        case signedIn
    }
    
    @Published var state: State = .signedOut
    
    private let dependency: SlothAppDependencyContainer
    
    init(dependecy: SlothAppDependencyContainer) {
        self.dependency = dependecy
    }
    
    func checkHasToken() {
        if validateAccessToken() {
            state = .signedIn
        } else {
            state = .signedOut
        }
    }
    
    private func validateAccessToken() -> Bool {
        if validateExistAccessToken() && validateAccessTokenExpireTime() {
            return true
        } else {
            removeAllTokenInfo()
            return false
        }
    }
    
    private func validateExistAccessToken() -> Bool {
        return dependency.keyChainManager.isExistKey(key: .accessToken)
    }
    
    private func validateAccessTokenExpireTime() -> Bool {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let accessTokenExpireTime = dependency.keyChainManager.getValue(forKey: .accessTokenExpireTime)
        let accessTokenExpireDate = dateFormatter.date(from: accessTokenExpireTime) ?? Date.init()
        let currentDate = Date.init()
        
        if currentDate >= accessTokenExpireDate {
            return false
        }
        
        return true
    }
    
    private func removeAllTokenInfo() {
        dependency.keyChainManager.remove(forKey: .accessToken)
        dependency.keyChainManager.remove(forKey: .accessTokenExpireTime)
        dependency.keyChainManager.remove(forKey: .refreshToken)
        dependency.keyChainManager.remove(forKey: .refreshTokenExpireTime)
    }
}
