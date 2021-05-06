//
//  cryptoGraphyTests.swift
//  walletTests
//
//  Created by Payam on 5/6/21.
//


import XCTest
@testable import wallet

class cryptoGraphyTests: XCTestCase {
    
    func testGenerateKeysNotnil() {
        let bls_test = BLS()
        bls_test.GenerateKeys()
        
        
        XCTAssertNotNil(bls_test.secretKey)
        XCTAssertNotNil(bls_test.mnemonicWords)
        XCTAssertNotNil(bls_test.publicKey)
        
    }
    
    func testGenerateKeysCheckBytesEquality() {
        let bls_test = BLS()
        bls_test.GenerateKeys()
        
        XCTAssertEqual(bls_test.secretKey.count, 64)
        XCTAssertEqual(bls_test.publicKey.count, 192)
        XCTAssertGreaterThan(bls_test.mnemonicWords.count, 1)

        
    }
    
    
}
