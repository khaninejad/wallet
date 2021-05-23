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
    private var CBORTransaction = CBORWrapper.init()
    init() {
        
    }
    
    func Send(){
        let publicKey = keychainWrapper.getKey(key: "publicKey")!
        let signedMessage = "msg"
        let latestBlock = "1000"
        let numberOfTransaction = 0
        CBORTransaction.setSendPayload(sender: keychainWrapper.getKey(key: "address")!, reciver: SendTransaction.RecieverAddress, amount:Int( SendTransaction.Amount)!)
      let hex =   CBORTransaction.setTransactionPayload(publicKey: publicKey, signature: signedMessage, latestBlockStamp: latestBlock, numberOfSenderTransaction: numberOfTransaction, fee: 1000, memo: SendTransaction.Memo)
        print(hex)
    }
}
struct TransactionFields: Decodable {
    var RecieverAddress: String = ""
    var Amount: String = "0"
    var Memo : String = ""
    
}
