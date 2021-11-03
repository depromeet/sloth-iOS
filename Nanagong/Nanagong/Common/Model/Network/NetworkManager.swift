//
//  NetworkManager.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/14.
//

import Combine
import Foundation
import SlothNetworkModule

final class NetworkManager {
    
    private let requester: NetworkManageable
    private let keyChainManager: KeyChaingWrapperManagable
    
    init(requester: NetworkManageable, keyChainManager: KeyChaingWrapperManagable) {
        self.requester = requester
        self.keyChainManager = keyChainManager
    }
    
    func dataTaskPublisher(for url: URL?, httpMethod: HTTPMethod, httpHeaders: HTTPHeaders) -> AnyPublisher<Data, NetworkError> {
        let headers = makeHeaders(httpHeaders)
        
        return requester.dataTaskPublisher(for: url, httpMethod: httpMethod, httpHeaders: headers)
    }
    
    func dataTaskPublisher(for urlString: String, httpMethod: HTTPMethod, httpHeaders: HTTPHeaders) -> AnyPublisher<Data, NetworkError> {
        let headers = makeHeaders(httpHeaders)
        
        return requester.dataTaskPublisher(for: urlString, httpMethod: httpMethod, httpHeaders: headers)
    }
    
    private func makeHeaders(_ originalHeader: HTTPHeaders) -> HTTPHeaders {
        var commonHeader: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let tokenHeader = makeAccessTokenHeader()
        
        commonHeader?.merge(originalHeader ?? [:])
        commonHeader?.merge(tokenHeader ?? [:])
        
        return commonHeader
    }
    
    private func makeAccessTokenHeader() -> HTTPHeaders {
        if !keyChainManager.isExistKey(key: .accessToken) { return nil }
        
        let accessToken = keyChainManager.getValue(forKey: .accessToken)
        let accessTokenExpireTime = keyChainManager.getValue(forKey: .accessTokenExpireTime)
        let refreshToken = keyChainManager.getValue(forKey: .refreshToken)
        let refreshTokenExpireTime = keyChainManager.getValue(forKey: .refreshTokenExpireTime)
        
        let tokenHeader: HTTPHeaders = [
            
            keyChainManager.string(forKey: .accessToken) : accessToken,
            keyChainManager.string(forKey: .accessTokenExpireTime) : accessTokenExpireTime,
            keyChainManager.string(forKey: .refreshToken) : refreshToken,
            keyChainManager.string(forKey: .refreshTokenExpireTime) : refreshTokenExpireTime
        ]
        
        return tokenHeader
    }
}
