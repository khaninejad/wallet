//
//  SortitionPayload.swift
//  wallet
//
//  Created by Payam on 5/22/21.
//

import Foundation
import CBOR

struct SortitionPayload: CBOREncodable {
    var Address: String
    var  Proof   :  String
    

    public func encode() -> [UInt8] {
        let cborWrapper : CBOR = [
            "Address": CBOR.utf8String(self.Address),
            "Proof": CBOR.utf8String(self.Proof)
        ]
        return cborWrapper.encode()
    }
}
