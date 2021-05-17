//
//  UserLoginViewModelTests.swift
//  walletTests
//
//  Created by Payam on 5/17/21.
//

import XCTest
@testable import wallet

class UserLoginViewModelTests: XCTestCase {
    
    func testLoadKeys() {
        let mock = UserLoginViewModel()
        mock.setPrivateKey(value: nil)
        let result =  mock.validateKeyExists()
        XCTAssertFalse(result)
        mock.setPrivateKey(value: "123")
        let resultNotNil =  mock.validateKeyExists()
        XCTAssertTrue(resultNotNil)
    }
    func testLoadKeysLoginValid() {
        let mock = UserLoginViewModel()
        mock.setPrivateKey(value: "123")
        mock.login()
        XCTAssertTrue(mock.loginState)
    }
    func testLoadKeysLoginNotValidValid() {
        let mock = UserLoginViewModel()
        mock.setPrivateKey(value:nil)
        mock.login()
        XCTAssertFalse(mock.loginState)
        
    }
    
    
}
