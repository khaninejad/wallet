//
//  SendPayload.swift
//  wallet
//
//  Created by Payam on 5/22/21.
//

import Foundation
import CBOR


struct SendPayload: CBOREncodable {
    var Sender: String
    var  Receiver   :  String
    var  Amount :  Int

    public func encode() -> [UInt8] {
        let cborWrapper : CBOR = [
            "Sender": CBOR.utf8String(self.Sender),
            "Receiver": CBOR.utf8String(self.Receiver),
            "Amount": CBOR(integerLiteral: self.Amount)
        ]
        return cborWrapper.encode()
    }
}


