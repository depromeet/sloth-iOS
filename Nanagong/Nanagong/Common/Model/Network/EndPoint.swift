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
        urlComponents.path = urlInformation.path
        
        return urlComponents.url
    }
    
    enum URLInformation {
        
        case signIn
        
        case categoryList
        
        case siteList
        
        case registerLesson
        
        var path: String {
            switch self {
            case .signIn:
                return "/api/oauth/login"
                
            case .categoryList:
                return "/api/category/list"
                
            case .siteList:
                return "/api/site/list"
                
            case .registerLesson:
                return "/api/lesson"
            }
        }
    }
}
