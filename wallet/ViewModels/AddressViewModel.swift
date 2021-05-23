//
//  AddressViewModel.swift
//  wallet
//
//  Created by Payam on 5/24/21.
//

import Foundation
class AddressViewModel {
    var addressModel : Address
    init(address: Address) {
        self.addressModel = address
    }
    var address: String {
        return self.addressModel.address ?? ""
    }

    var number: Int? {
        return self.addressModel.number
    }

    var sequence: Int? {
        return self.addressModel.sequence
    }
    var balance: Int? {
        return self.addressModel.balance
    }
    var realBalance: Int? {
        if (self.addressModel.balance != nil) {
            return self.addressModel.balance! / 100000000
        }
        return 0
        
    }
}
