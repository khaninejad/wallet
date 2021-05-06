//
//  extentionTests.swift
//  walletTests
//
//  Created by Payam on 5/7/21.
//

import XCTest

class extentionTests: XCTestCase {

    func testStringToHex() {
       let testHex = "123".data(using: .utf8)!
        
        XCTAssertNotNil(testHex.toHexString())
        XCTAssertEqual([15, 0, 255].toHexString(), "0f00ff")
        XCTAssertEqual([240, 159,143, 179, 239 ,184 ,143, 226 ,128 ,141 ,240 ,159,140 ,136].toHexString(), "f09f8fb3efb88fe2808df09f8c88")

        
    }

}
