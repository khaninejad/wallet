//
//  BLS.swift
//  wallet
//
//  Created by Payam on 5/4/21.
//

import Foundation
import bls_framework
import CryptoSwift

class BLS {
    init() {
        do {
         try   BLSInterface.blsInit()
        } catch {
            
        }
    }
    
    func GetKeys()  {
       
        do {
         try   BLSInterface.blsInit()
        } catch {
            
        }
        var sec = blsSecretKey.init()
        blsSecretKeySetByCSPRNG(&sec)
        
        
        let SECRET_KEY_SIZE = 32
        var secretKeyBytes = Data(count: SECRET_KEY_SIZE).bytes // [UInt8]
        blsSecretKeySerialize(&secretKeyBytes, SECRET_KEY_SIZE, &sec)
        let secretString = Data(secretKeyBytes).hexEncodedString()
        print(secretString)

 
        
        var pub = blsPublicKey.init()
        blsGetPublicKey(&pub, &sec);
        
        let PUBLIC_KEY_SIZE = 48
        var publicKeyBytes = Data(count: PUBLIC_KEY_SIZE).bytes // [UInt8]
        blsPublicKeySerialize(&publicKeyBytes, PUBLIC_KEY_SIZE, &pub)
        print(Data(publicKeyBytes).hexEncodedString())
        
        let mem = Mnemonic()
        let words =   mem.GenerateMnemonic(hex: secretString)
        let secretRecover =    mem.GenerateSecretFromMnemonic(words: words)
        print(words)
        print(secretRecover)
        


//
    }

    
   




}
extension UInt64 {
   var bytes: [UInt8] {
       withUnsafeBytes(of: self, Array.init)
   }
}
extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}
