//
//  Address.swift
//  wallet
//
//  Created by Payam on 5/5/21.
//

import Foundation
import CryptoKit


class Address {
    
    
    
    func GenerateAddress(publicAddress : String){
        guard let data = publicAddress.data(using: .utf8) else { return }
        let digest = SHA256.hash(data: data)
        print(digest.data) // 32 bytes
        print(digest.hexStr) // B94D27B9934D3E08A52E52D7DA7DABFAC484EFE37A5380EE9088F7ACE2EFCDE9
        GenerateHash160(hash256: digest.hexStr)
    }
    func GenerateHash160(hash256: String){
        
        let hash = RIPEMD160.hash(message: hash256).hexEncodedString()
        print(hash) // a830d7beb04eb7549ce990fb7dc962e499a27230
        GenerateBech32(hex: hash)
    }
    func GenerateBech32(hex: String){
        
        do {
            //            let bech32 = Bech32()
            //            let (_, checksum) = try! bech32.
            //            var ddd = try! bech32.convertBits(from: 5, to: 8, pad: false, idata: checksum).bytes
            let bech32 = Bech32()
            let grouped = try! bech32.convertBits(from: 8, to: 5, pad: true, idata: Data(bytes: hex.bytes, count: 20))
            var ttss = bech32.encode("zrb", values: grouped)
            print(ttss)
        } catch {
            
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
