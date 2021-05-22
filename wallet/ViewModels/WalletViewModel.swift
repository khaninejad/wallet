//
//  WalletViewModel.swift
//  wallet
//
//  Created by Payam on 5/6/21.
//

import Foundation
class WalletViewModel : ObservableObject {
    
    @Published var keys = KeysViewModel()
    
    @Published var created : Bool = false
    
    init() {
        
        
    }
    func  Generate() {
        let blsObject = BLS()
        blsObject.GenerateKeys()
        
        
        self.keys.publicKey = blsObject.publicKey
        setPrivateKey(privateKey: blsObject.secretKey)
        self.keys.mnemonicWords = blsObject.mnemonicWords
        
        SaveKeys();
        
    }
    func SaveKeys(){
        let keychain = Keychain.init()
        let privateKeySaveResult =    keychain.saveKey(key: "privateKey", value: self.keys.secretKey)
        let publicKeySaveResult =  keychain.saveKey(key: "publicKey", value: self.keys.publicKey)
        if (privateKeySaveResult == true && publicKeySaveResult == true){
            self.created = true;
        }
    }
    func RecoverKeys(words: [String]){
        do {
            if (words.count != 24) {
                throw AppErrorException.InvalidWordCount
            }
            let secretKey =   BLS.init().RecoverMnemonic(input: words)
            setPrivateKey(privateKey: secretKey)
            let publicKey = BLS.init().GeneratePublicKey(key:  secretKey)
            
            
            SaveKeys()
            
        } catch AppErrorException.InvalidWordCount {
            print("InvalidWordCount")
        }
        catch {
            print("Unexpected, not otherwise caught, error: \(error)")
        }
    }
    func setPrivateKey(privateKey: String){
        self.keys.secretKey = privateKey
    }
    
    
}





struct KeysViewModel: Decodable {
    var secretKey: String = ""
    var publicKey: String = ""
    var mnemonicWords = [String]()
    
}

