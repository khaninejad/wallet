//
//  BondPayload.swift
//  wallet
//
//  Created by Payam on 5/22/21.
//

import Foundation

import CBOR


struct BondPayload: CBOREncodable {
    var Bonder: String
    var  Validator   :  String
    var  Stake :  Int

    public func encode() -> [UInt8] {
        let cborWrapper : CBOR = [
            "1": CBOR.utf8String(self.Bonder),
            "2": CBOR.utf8String(self.Validator),
            "3": CBOR(integerLiteral: self.Stake)
        ]
        return cborWrapper.encode()
    }
}


