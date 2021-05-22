//
//  Transaction.swift
//  wallet
//
//  Created by Payam on 5/22/21.
//

import Foundation
import CBOR

public protocol CBOREncodable {
    func encode() -> [UInt8]
}

struct Transaction: CBOREncodable {
    var Version: Int
    var  Stamp   :  String
    var  Sequence :  Int
    var  Fee    :   Int
    var  TypeT    :  PayloadType
    var  Payload : SendPayload
    var  Memo   :   String
    var  PublicKey : String
    var  Signature : String

    public func encode() -> [UInt8] {
        let cborWrapper : CBOR = [
            "Version": CBOR(integerLiteral: self.Version),
            "Stamp": CBOR.utf8String(self.Stamp),
            "Sequence": CBOR(integerLiteral: self.Sequence),
            "Fee": CBOR(integerLiteral: self.Fee),
            "Payload": try!  CBOR.decode( self.Payload.encode())!,
            "Type": CBOR(integerLiteral: self.TypeT.getvalue()),
            "Memo": CBOR.utf8String(self.Memo),
            "PublicKey": CBOR.utf8String(self.PublicKey),
            "Signature": CBOR.utf8String(self.Signature)
        ]
        return cborWrapper.encode()
    }
}


enum PayloadType : Int {
    case PayloadTypeSend = 1
    case PayloadTypeBond = 2
    case PayloadTypeSortition = 3

    
    func getvalue() -> Int {
        return self.rawValue
    }
}
