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
            "1": CBOR(integerLiteral: self.Version),
            "2": CBOR.utf8String(self.Stamp),
            "3": CBOR(integerLiteral: self.Sequence),
            "4": CBOR(integerLiteral: self.Fee),
            "6": try!  CBOR.decode( self.Payload.encode())!,
            "5": CBOR(integerLiteral: self.TypeT.getvalue()),
            "7": CBOR.utf8String(self.Memo),
            "20": CBOR.utf8String(self.PublicKey),
            "21": CBOR.utf8String(self.Signature)
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
