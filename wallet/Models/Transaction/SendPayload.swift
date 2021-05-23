//
//  SendPayload.swift
//  wallet
//
//  Created by Payam on 5/22/21.
//

import Foundation
import CBOR


struct SendPayload: CBOREncodable {
   private var Sender: [UInt8]
    private var  Receiver   :  [UInt8]
    private  var  Amount :  Int
 
    
    init(sender: [UInt8], reciever: [UInt8], amount: Int) {
        self.Receiver = sender
        self.Amount = amount
        self.Sender = reciever
    }

    public func encode() -> [UInt8] {
        let cborWrapper : CBOR = [
            "1":CBOR.byteString(self.Sender),
            "2": CBOR.byteString(self.Receiver),
            "3": CBOR(integerLiteral: self.Amount)
        ]
        return cborWrapper.encode()
    }
}


