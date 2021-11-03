//
//  OnBoardingViewModel.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/30.
//

import Foundation
import Combine

final class OnBoardingViewModel {
    
    enum OnBoardingViewState {
        
        case signIn
        case privacy
        case next
    }
    
    private let keyChainManager: KeyChaingWrapperManagable
    private var currentState: OnBoardingViewState = .signIn
    @Published var viewState: OnBoardingViewState = .signIn
    
    init(keyChainManager: KeyChaingWrapperManagable) {
        self.keyChainManager = keyChainManager
        self.removeAllTokenInfo()
        setUpCurrentState()
    }
    
    func present() {
        setUpCurrentState()
        viewState = currentState
    }
    
    func changeViewState(state: OnBoardingViewState) {
        currentState = state
        viewState = state
    }
    
    private func setUpCurrentState() {
        currentState = validateAccessToken() ? .privacy : .signIn
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
        return keyChainManager.isExistKey(key: .accessToken)
    }
    
    private func validateAccessTokenExpireTime() -> Bool {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let accessTokenExpireTime = keyChainManager.getValue(forKey: .accessTokenExpireTime)
        let accessTokenExpireDate = dateFormatter.date(from: accessTokenExpireTime) ?? Date.init()
        let currentDate = Date.init()
        
        if currentDate >= accessTokenExpireDate {
            return false
        }
        
        return true
    }
    
    private func removeAllTokenInfo() {
        keyChainManager.remove(forKey: .accessToken)
        keyChainManager.remove(forKey: .accessTokenExpireTime)
        keyChainManager.remove(forKey: .refreshToken)
        keyChainManager.remove(forKey: .refreshTokenExpireTime)
    }
}
