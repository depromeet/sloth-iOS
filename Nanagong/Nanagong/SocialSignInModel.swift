//
//  SocialSignInModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/15.
//

import Foundation

enum SocialSignInType: String, CustomStringConvertible {
    
    case apple
    case google
    case kakao
    
    var description: String {
        return self.rawValue.uppercased()
    }
}

struct SocialSignInBody: Codable {
    
    private let socialType: String
    
    init(socialSignInType: SocialSignInType) {
        self.socialType = "\(socialSignInType)"
    }
}

struct SocialSignInResponse: Codable {
    
    let accessToken: String
    let accessTokenExpireTime: String
    let refreshToken: String
    let refreshTokenExpireTime: String
}
