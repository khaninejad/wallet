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
    var signature = String()
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
        self.secretKey = secretKeyBytes.toHexString()
        
        return sec
    }
    func GeneratePublicKey(sec: inout blsSecretKey) -> blsPublicKey {
        var pub = blsPublicKey.init()
        blsGetPublicKey(&pub, &sec);
        
//
        let PUBLIC_KEY_SIZE = 96
        var publicKeyBytes = Data(count: PUBLIC_KEY_SIZE).bytes // [UInt8]
        blsPublicKeySerialize(&publicKeyBytes, PUBLIC_KEY_SIZE, &pub)
        self.publicKey = publicKeyBytes.toHexString()

        return pub
        
    }
    func GeneratePublicKey(key: String) -> String {
        init_BLS()

        var serializedSecretKey = Data(hex: key).bytes // [UInt8]

        var secretKey = blsSecretKey.init()
        blsSecretKeyDeserialize(&secretKey, &serializedSecretKey, numericCast(serializedSecretKey.count))
        
        var publicKey = blsPublicKey.init()
        blsGetPublicKey(&publicKey, &secretKey)
        
        let PUBLIC_KEY_SIZE = 96
        var publicKeyBytes = Data(count: PUBLIC_KEY_SIZE).bytes // [UInt8]
        blsPublicKeySerialize(&publicKeyBytes, PUBLIC_KEY_SIZE, &publicKey)
        self.publicKey = publicKeyBytes.toHexString()
        return self.publicKey

     
    }
    func getSecretKeyFromHex(key: String) -> blsSecretKey{
        init_BLS()

        var serializedSecretKey = Data(hex: key).bytes // [UInt8]

        var secretKey = blsSecretKey.init()
        blsSecretKeyDeserialize(&secretKey, &serializedSecretKey, numericCast(serializedSecretKey.count))
        return secretKey
    }
    func Serialize(msg: String, secretkey: String) -> String {
        init_BLS()
        
        var serializedSecretKey = Data(hex: secretkey).bytes // [UInt8]

        var secretKey = blsSecretKey.init()
        blsSecretKeyDeserialize(&secretKey, &serializedSecretKey, numericCast(serializedSecretKey.count))
        
        var publicKey = blsPublicKey.init()
        blsGetPublicKey(&publicKey, &secretKey)

        var sig = blsSignature.init()
        var serializedMsg = msg.bytes
        let msgSize = serializedMsg.count

       blsSign(&sig, &secretKey, serializedMsg, msgSize);
        
        let Sign_KEY_SIZE = 48
        var SignBytes = Data(count: Sign_KEY_SIZE).bytes // [UInt8]
        blsSignatureSerialize(&SignBytes, Sign_KEY_SIZE, &sig)
        
        
        
        let res =  blsVerify(&sig, &publicKey, serializedMsg, msgSize);
        
        self.signature = SignBytes.toHexString()
        print(SignBytes.toHexString())
        return self.signature

     
    }
    
    
    func GenerateMnemonic(input: String ) -> [String] {
        let mem = Mnemonic()
        let words = try! mem.GenerateMnemonic(hex: input)
        print (words)
        return words
    }
    func RecoverMnemonic(input: [String]) -> String {
        let mem = Mnemonic()
        
        return   mem.GenerateSecretFromMnemonic(words: input)
    }
    func GenerateKeys()  {     
       var sec = GenerateSecretKey()
       GeneratePublicKey(sec: &sec)

        
        //self.publicKey = GeneratePublicKey(sec: &sec)
        self.mnemonicWords = GenerateMnemonic(input: self.secretKey)
    }
    
}
