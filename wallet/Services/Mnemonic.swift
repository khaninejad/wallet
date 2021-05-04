//
//  Mnemonic.swift
//  wallet
//
//  Created by Payam on 5/5/21.
//

import Foundation
import BIP39

class Mnemonic {
    
    func GenerateMnemonic(hex: String) -> [String] {
        let dataWords =  BIP39Util.mnemonicsFromSecret(Data(hex: hex))
        return (dataWords)!
    }
    func GenerateSecretFromMnemonic(words: [String]) -> String {
        let secret =  BIP39Util.secretFromMnemonics(words)
        return (secret?.bytes.toHexString())!
    }
}
