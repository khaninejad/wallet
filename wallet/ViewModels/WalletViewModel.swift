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
        self.keys.secretKey = blsObject.secretKey
        self.keys.mnemonicWords = blsObject.mnemonicWords
    }
    
}



struct KeysViewModel: Decodable {
    var secretKey: String = ""
    var publicKey: String = ""
    var mnemonicWords = [String]()



}

