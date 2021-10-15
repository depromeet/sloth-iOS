//
//  EndPoint.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/15.
//

import Foundation

struct EndPoint {
    
    private let scheme: String = "https"
    private let host: String = "slothbackend.hopto.org"
    private let urlInformation: URLInformation
    
    init(urlInformation: URLInformation) {
        self.urlInformation = urlInformation
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = urlComponents.path
        
        return urlComponents.url
    }
    
    enum URLInformation {
        
        case signIn
        
        var path: String {
            return "api/oauth/login"
        }
    }
}
