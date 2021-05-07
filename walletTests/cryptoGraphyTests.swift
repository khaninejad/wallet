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
    
    func testGenerateSH256() {
        let sh256 = Address()
        let data = sh256.GenerateSHA256(input: "zarb")
        let hex =   data.hexEncodedString()
        XCTAssertEqual(data.count, 32)
        XCTAssertEqual(hex, "b61da6e0d5f482faf731dd24f811e7db3cbf87c2fa7af46b631782ac03a0fa1e")
        let publicKey = "37bfe636693eac0b674ae6603442192ef0432ad84384f0cec8bea5f63c9f45c29bf085b8b9b7f069ae873ccefe61a50a59ad3fefd729af5d63e9cb2325a8f064ab2514b3f846dbfded53234800603a9e752422ad48b99f835bcd95df945aac93"
        let dataPublic = sh256.GenerateSHA256(input: publicKey)
        let hexPublic =   dataPublic.hexEncodedString()
        XCTAssertEqual(hexPublic, "f3da6cf798f8ab6fb71a005be9c34e5fcd04209b842af189ce18b4920ae12553")

    }
    func testGenerateHash160() {
        let hash160 = Address()
        XCTAssertEqual(hash160.GenerateHash160(hash256: "").count, 20)
        XCTAssertEqual(hash160.GenerateHash160(hash256: "").hexEncodedString(), "9c1185a5c5e9fc54612808977ee8f548b2258d31")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "a").hexEncodedString(), "0bdc9d2d256b3ee9daae347be6f4dc835a467ffe")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "abc").hexEncodedString(), "8eb208f7e05d987a9b044a8e98c6b087f15a0bfc")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "message digest").hexEncodedString(), "5d0689ef49d2fae572b881b123a85ffa21595f36")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "f3da6cf798f8ab6fb71a005be9c34e5fcd04209b842af189ce18b4920ae12553").hexEncodedString(), "4271ca407e04ff7a6edba719fc41301f3de2e6da")

    }
    
    func testGenerateBech32() {
        let hash160 = Address()
        XCTAssertEqual(hash160.GenerateBech32(hex:Data(hex: "f6edd7e1d53d730a3ae0d44e6b6ce5dc102c0b63"),  hrp: "zrb"), "zrb17mka0cw484es5whq638xkm89msgzczmrwy64dy")


    }
    
    
}
