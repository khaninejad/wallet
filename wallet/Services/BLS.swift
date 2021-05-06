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
    var secretKey = String()
    var publicKey = String()
    var mnemonicWords = [String]()

    
    func init_BLS(){
        do {
            try   BLSInterface.blsInit()
        } catch {
            
        }
    }
    func GenerateSecretKey() -> blsSecretKey {
        init_BLS()
        var sec = blsSecretKey.init()
        blsSecretKeySetByCSPRNG(&sec)
        
        let SECRET_KEY_SIZE = 32
        var secretKeyBytes = Data(count: SECRET_KEY_SIZE).bytes // [UInt8]
        blsSecretKeySerialize(&secretKeyBytes, SECRET_KEY_SIZE, &sec)
        let secretString = Data(secretKeyBytes).hexEncodedString()
        secretKey = secretString
        
        return sec
    }
    func GeneratePublicKey(sec: inout blsSecretKey) -> String {
        var pub = blsPublicKey.init()
        blsGetPublicKey(&pub, &sec);
        
        let PUBLIC_KEY_SIZE = 96
        var publicKeyBytes = Data(count: PUBLIC_KEY_SIZE).bytes // [UInt8]
        blsPublicKeySerialize(&publicKeyBytes, PUBLIC_KEY_SIZE, &pub)
        return Data(publicKeyBytes).hexEncodedString()
        
        
    }
    func GenerateMnemonic(input: String ) -> [String] {
        let mem = Mnemonic()
        return  try! mem.GenerateMnemonic(hex: input)
    }
    func GenerateKeys()  {     
       var sec = GenerateSecretKey()
        self.publicKey = GeneratePublicKey(sec: &sec)
        self.mnemonicWords = GenerateMnemonic(input: self.secretKey)

        
    }
    
}
