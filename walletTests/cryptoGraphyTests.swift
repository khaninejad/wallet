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
    func testPrivateKeyDeSerialize(){
        let bls_test = BLS()
        let publicKey = bls_test.GeneratePublicKey(key: "d0c6a560de2e60b6ac55386defefdf93b0c907290c2ad1b4dbd3338186bfdc68")
        XCTAssertEqual(publicKey, "37bfe636693eac0b674ae6603442192ef0432ad84384f0cec8bea5f63c9f45c29bf085b8b9b7f069ae873ccefe61a50a59ad3fefd729af5d63e9cb2325a8f064ab2514b3f846dbfded53234800603a9e752422ad48b99f835bcd95df945aac93")
       
        
    }
    func testAddressGenerateFromScratch(){
        let bls_test = BLS()
        let publicKey2 = bls_test.GeneratePublicKey(key: "79d8747b47287faf786e9d12")
        let obj = AddressWrapper()
        let blake2 = obj.GenerateSHA256(input:publicKey2)
        let hash160 = obj.GenerateHash160(hash256: blake2)
        let address = obj.GenerateBech32(hex: hash160,  hrp: "zrb")
        XCTAssertEqual( address, "zrb1h9acqh3echsup7mlxt5jdvq4sfzjrnuz9cwpye")
    }
    func testsignatureSerialize(){
        let bls_test = BLS()
       
        let serialized =  bls_test.Sign(msg: "zarb", secretkey: "d0c6a560de2e60b6ac55386defefdf93b0c907290c2ad1b4dbd3338186bfdc68")
        XCTAssertEqual(serialized, "5f1080090499741fb94f8b5022f0f75650cf9f3cd1d235fe7440bc772ac63d5cc246405f424214ebc1af814bdcca7882")
        
    }
    
    func testGenerateSH256() {
        let sh256 = AddressWrapper()
        let data = sh256.GenerateSHA256(input: "zarb")
        let hex =   data
        XCTAssertEqual(data.count, 64)
        XCTAssertEqual(hex, "12b38977f2d67f06f0c0cd54aaf7324cf4fee184398ea33d295e8d1543c2ee1a")
        let publicKey = "37bfe636693eac0b674ae6603442192ef0432ad84384f0cec8bea5f63c9f45c29bf085b8b9b7f069ae873ccefe61a50a59ad3fefd729af5d63e9cb2325a8f064ab2514b3f846dbfded53234800603a9e752422ad48b99f835bcd95df945aac93"
        let dataPublic = sh256.GenerateSHA256(input: publicKey)
        let hexPublic =   dataPublic
        XCTAssertEqual(hexPublic, "a8dd00e0228a376d51064126452b5a718319e204bb27154500709ddc1bc305f1")

    }
    func testGenerateHash160() {
        let hash160 = AddressWrapper()
        XCTAssertEqual(hash160.GenerateHash160(hash256: "").count, 20)
        XCTAssertEqual(hash160.GenerateHash160(hash256: "").hexEncodedString(), "9c1185a5c5e9fc54612808977ee8f548b2258d31")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "a").hexEncodedString(), "0bdc9d2d256b3ee9daae347be6f4dc835a467ffe")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "abc").hexEncodedString(), "8eb208f7e05d987a9b044a8e98c6b087f15a0bfc")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "message digest").hexEncodedString(), "5d0689ef49d2fae572b881b123a85ffa21595f36")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "f3da6cf798f8ab6fb71a005be9c34e5fcd04209b842af189ce18b4920ae12553").hexEncodedString(), "4271ca407e04ff7a6edba719fc41301f3de2e6da")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "a8dd00e0228a376d51064126452b5a718319e204bb27154500709ddc1bc305f1").hexEncodedString(), "1e5699a22796890066acc0b9ada8ee46782c02ca")
        XCTAssertEqual(hash160.GenerateHash160(hash256: "zarb").hexEncodedString(), "e93efc0c83176034cb828e39435eeecc07a29298")

    }
    
    func testGenerateBech32() {
        let hash160 = AddressWrapper()
        XCTAssertEqual(hash160.GenerateBech32(hex:Data(hex: "f6edd7e1d53d730a3ae0d44e6b6ce5dc102c0b63"),  hrp: "zrb"), "zrb17mka0cw484es5whq638xkm89msgzczmrwy64dy")


    }
    
    
}
