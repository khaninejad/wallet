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
            "1": CBOR.utf8String(self.Sender),
            "2": CBOR.utf8String(self.Receiver),
            "3": CBOR(integerLiteral: self.Amount)
        ]
        return cborWrapper.encode()
    }
}


