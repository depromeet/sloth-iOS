//
//  OnBoardingViewModel.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/30.
//

import Foundation
import Combine

final class OnBoardingViewModel {
    
    enum State {
        
        case signIn
        case privacy
        case next
    }
    
    @Published var viewState: State = .signIn
    
    private let keyChainManager: KeyChaingWrapperManagable
    private var currentState: State = .signIn
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(keyChainManager: KeyChaingWrapperManagable) {
        self.keyChainManager = keyChainManager
        setUpState()
    }
    
    func bindSignInViewState(_ state: AnyPublisher<SignInViewModel.State, Never>) {
        state
            .map(\.isSuccess)
            .sink { [weak self] isSuccess in
                guard let self = self else {
                    return
                }
                
                if self.validateAccessToken() && isSuccess {
                    self.currentState = .privacy
                }  else {
                    self.currentState = .signIn
                }
                
                self.viewState = self.currentState
            }.store(in: &anyCancellables)
    }
    
    func present() {
        viewState = currentState
    }
    
    private func setUpState() {
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
