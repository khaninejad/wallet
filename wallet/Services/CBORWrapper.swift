//
//  CBORWrapper.swift
//  wallet
//
//  Created by Payam on 5/22/21.
//

import Foundation
class CBORWrapper {
    init() {
        let send = SendPayload(Sender: "zrbdjdjjdd", Receiver: "zrbkkdskjdkjd", Amount: 10)
        let trans =  Transaction(Version: 1, Stamp: "stamp", Sequence: 50, Fee: 10, TypeT: PayloadType.PayloadTypeSend, Payload: send, Memo: "mem", PublicKey: "54s5df45sdf45sd4f5s4df", Signature: "hsjdhfhjasgdfhasgdfhjgsdf").encode()
        
        let bond = BondPayload(Bonder: "zrb", Validator: "validatir", Stake: 10).encode()
        print(trans.toHexString())
     
        print(bond.toHexString())
    }
}
