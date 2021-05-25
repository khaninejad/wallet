//
//  Address.swift
//  wallet
//
//  Created by Payam on 5/5/21.
//

import Foundation
import CryptoKit
import Blake2

class AddressWrapper {
    
    func GenerateSHA256(input: String) -> String {
        
        
        let data = Data(input.utf8)
        let hash = try! Blake2.hash(.b2b, size: 32, data: data)
        return hash.toHexString()
    }
    
    
    func GenerateAddress(publickey : String) -> String{
        
        let digest = GenerateSHA256(input: publickey)
        
        
        let hash160 = GenerateHash160(hash256: digest)
        return GenerateBech32(hex: hash160, hrp: "zrb")
    }
    func GenerateHash160(hash256: String) -> Data{
        let hash = RIPEMD160.hash(message: hash256)
        return hash
        
    }
    func GenerateBech32(hex: Data, hrp: String) -> String{
        
        do {
            let bech32 = Bech32()
            let grouped = try! bech32.convertBits(from: 8, to: 5, pad: true, idata: hex)
            return bech32.encode("zrb", values: grouped)
        } 
    }
    
    
    
    
}





extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }
    
    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
