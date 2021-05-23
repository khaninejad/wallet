//
//  CBORWrapper.swift
//  wallet
//
//  Created by Payam on 5/22/21.
//

import Foundation
class CBORWrapper {
    private var sendPayload = SendPayload(sender: [0x40], reciever: [0x40], amount: 0)
    init() {
        

    }
    func setSendPayload(sender: String, reciver: String, amount: Int){
        
        self.sendPayload = SendPayload(sender: sender.bytes, reciever: reciver.bytes, amount: amount)
        
    }
    func setTransactionPayload(publicKey: String, signature: String, latestBlockStamp: String, numberOfSenderTransaction: Int, fee: Int, memo: String)-> String{
        let trans =  Transaction(Version: 1, Stamp: latestBlockStamp.bytes, Sequence: numberOfSenderTransaction, Fee: fee, TypeT: PayloadType.PayloadTypeSend, Payload: self.sendPayload, Memo: memo, PublicKey: publicKey.bytes, Signature: signature.bytes).encode()
        return trans.toHexString()
    }
}
