//
//  KeychainWrapper.swift
//  wallet
//
//  Created by Payam on 5/17/21.
//

import Foundation
import SwiftKeychainWrapper

class Keychain {
    func getKey(key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key) ?? nil
    }
    func saveKey(key: String, value: String) -> Bool {
        return  KeychainWrapper.standard.set(value, forKey: key)
    }
    func deleteKey(key: String) -> Bool {
        return  KeychainWrapper.standard.removeObject(forKey: key)
    }
}
