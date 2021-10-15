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
    
    init(requester: NetworkManageable) {
        self.requester = requester
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
        
        commonHeader?.merge(originalHeader ?? [:])
        
        return commonHeader
    }
}
