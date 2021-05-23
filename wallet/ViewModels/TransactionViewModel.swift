//
//  TransactionViewModel.swift
//  wallet
//
//  Created by Payam on 5/23/21.
//

import Foundation

class TransactionViewModel {
    var SendTransaction = TransactionFields()
    let keychainWrapper = Keychain.init()
    let apiService =  APIService.init()
    private var CBORTransaction = CBORWrapper.init()
    private var numberOfTransaction = 0
    init() {
        
    }
    
    func Send(){
        
        apiService.getAddress(address: "zrb16gzvvnkr80uag0p7fcjmfrhct6g4g0t02scxcm") { address in
            let address =   address.map(AddressViewModel.init)
            self.numberOfTransaction = address?.sequence ?? 0
         }
        let publicKey = keychainWrapper.getKey(key: "publicKey")!
        let signedMessage = "msg"
        let latestBlock = "1000"
        
        CBORTransaction.setSendPayload(sender: keychainWrapper.getKey(key: "address")!, reciver: SendTransaction.RecieverAddress, amount:Int( SendTransaction.Amount)!)
      let hex =   CBORTransaction.setTransactionPayload(publicKey: publicKey, signature: signedMessage, latestBlockStamp: latestBlock, numberOfSenderTransaction: self.numberOfTransaction, fee: 1000, memo: SendTransaction.Memo)
        print(hex)
    }
}
struct TransactionFields: Decodable {
    var RecieverAddress: String = ""
    var Amount: String = "0"
    var Memo : String = ""
    
}
