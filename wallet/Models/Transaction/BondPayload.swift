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
            "Bonder": CBOR.utf8String(self.Bonder),
            "Validator": CBOR.utf8String(self.Validator),
            "Stake": CBOR(integerLiteral: self.Stake)
        ]
        return cborWrapper.encode()
    }
}


