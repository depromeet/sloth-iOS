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
    
    func dataTaskPublisher(for urlString: String, httpMethod: HTTPMethod, httpHeaders: HTTPHeaders) -> AnyPublisher<Data, NetworkError> {
        let headers = makeHeaders(httpHeaders)
        
        return requester.dataTaskPublisher(for: urlString, httpMethod: httpMethod, httpHeaders: headers)
    }
    
    private func makeHeaders(_ originalHeader: HTTPHeaders) -> HTTPHeaders {
        return originalHeader
    }
}
