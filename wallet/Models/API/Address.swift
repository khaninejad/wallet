//
//  Address.swift
//  wallet
//
//  Created by Payam on 5/24/21.
//

import Foundation
struct Address :  Decodable {
    let address : String?
    let number : Int?
    let sequence : Int?
    let balance : Int?

    enum CodingKeys: String, CodingKey {

        case address = "Address"
        case number = "Number"
        case sequence = "Sequence"
        case balance = "Balance"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        sequence = try values.decodeIfPresent(Int.self, forKey: .sequence)
        balance = try values.decodeIfPresent(Int.self, forKey: .balance)
    }

}
