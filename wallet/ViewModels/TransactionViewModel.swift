//
//  TransactionViewModel.swift
//  wallet
//
//  Created by Payam on 5/23/21.
//

import Foundation

class TransactionViewModel {
    var SendTransaction = TransactionFields()
    init() {
        
    }
}
struct TransactionFields: Decodable {
    var RecieverAddress: String = ""
    var Amount: Int = 0
    var Memo : String = ""
    
}
