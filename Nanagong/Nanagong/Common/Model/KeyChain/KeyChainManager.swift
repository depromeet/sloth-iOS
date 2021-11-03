//
//  KeyChainManager.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/30.
//

import Foundation
import SwiftKeychainWrapper

protocol KeyChaingWrapperManagable {
    func save(_ setValue: String, forKey key: KeychainWrapper.Key)
    func remove(forKey key: KeychainWrapper.Key)
    func string(forKey key: KeychainWrapper.Key) -> String
    func getValue(forKey key: KeychainWrapper.Key) -> String
    func isExistKey(key: KeychainWrapper.Key) -> Bool
}

final class KeyChainWrapperManager: KeyChaingWrapperManagable {
    
    func save(_ setValue: String, forKey key: KeychainWrapper.Key) {
        KeychainWrapper.standard[key] = setValue
    }
    
    func remove(forKey key: KeychainWrapper.Key) {
        KeychainWrapper.standard.remove(forKey: key)
    }
    
    func string(forKey key: KeychainWrapper.Key) -> String {
        return key.rawValue
    }
    
    func getValue(forKey key: KeychainWrapper.Key) -> String {
        return KeychainWrapper.standard.string(forKey: key) ?? ""
    }
    
    func isExistKey(key: KeychainWrapper.Key) -> Bool {
        return KeychainWrapper.standard.string(forKey: key) != nil
    }
}
