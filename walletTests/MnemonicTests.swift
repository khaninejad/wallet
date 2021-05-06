//
//  MnemonicTests.swift
//  walletTests
//
//  Created by Payam on 5/7/21.
//

import XCTest
@testable import wallet

class MnemonicTests: XCTestCase {
    
    
    func testStringToHex_throw() {
        let test = Mnemonic()
        XCTAssertThrowsError (try test.GenerateMnemonic(hex: "123456") )
    }
    
    func testStringToHex_equal() {
        let test = Mnemonic()
        
        
       let words = try! test.GenerateMnemonic(hex: "795bf7a4cc4e1ebc66a532471ce23d6efe710baa7db8747b47287faf786e9d12")
        
        XCTAssertNotNil(words)
        XCTAssertGreaterThan(words.count, 0)
        XCTAssertEqual(words.count, 24)
        XCTAssertEqual(words[0], "junk")
        XCTAssertEqual(words[23], "flush")
        XCTAssertEqual(words[12], "train")


        
    }

}
