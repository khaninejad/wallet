//
//  keychainTests.swift
//  walletTests
//
//  Created by Payam on 5/17/21.
//

import XCTest
@testable import wallet
class keychainTests: XCTestCase {

    func testGenerateKeysNotnil() {
        let keychain = Keychain()
        let key = keychain.saveKey(key: "test", value: "test")
        let keyGet = keychain.getKey(key: "test")
        let keyDelete = keychain.deleteKey(key: "test")
        XCTAssertTrue(key)
        XCTAssertNotNil(keyGet)
        XCTAssertEqual(keyGet, "test")
        XCTAssertTrue(keyDelete)
        
    }

  

}
