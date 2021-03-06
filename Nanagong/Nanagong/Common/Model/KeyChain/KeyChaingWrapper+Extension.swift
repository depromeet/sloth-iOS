//
//  KeyChaingWrapper+Extension.swift
//  Nanagong
//
//  Created by μμΉν on 2021/10/29.
//

import Foundation
import SwiftKeychainWrapper

extension KeychainWrapper.Key {
    
    static let accessToken: KeychainWrapper.Key = "accessToken"
    static let accessTokenExpireTime: KeychainWrapper.Key = "accessTokenExpireTime"
    static let refreshToken: KeychainWrapper.Key = "refreshToken"
    static let refreshTokenExpireTime: KeychainWrapper.Key = "refreshTokenExpireTime"
}
