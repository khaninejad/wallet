//
//  Mnemonic.swift
//  wallet
//
//  Created by Payam on 5/5/21.
//

import Foundation
import BIP39

class Mnemonic {
    
    func GenerateMnemonic(hex: String) throws ->  [String] {
        
        let dataWords =   BIP39Util.mnemonicsFromSecret(Data(hex: hex))
        if dataWords != nil {
            return dataWords!
        }else{
            throw "Some Error"
        }
        
        
    }
    func GenerateSecretFromMnemonic(words: [String]) -> String {
        let secret =  BIP39Util.secretFromMnemonics(words)
        return (secret?.bytes.toHexString())!
    }
    
    
    
}
extension String: Error {}
