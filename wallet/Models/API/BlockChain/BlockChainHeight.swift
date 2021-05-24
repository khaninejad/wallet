//
//  BlockChainHeight.swift
//  wallet
//
//  Created by Payam on 5/24/21.
//

import Foundation
struct BlockChainHeight : Codable {
    let height : Int?

    enum CodingKeys: String, CodingKey {

        case height = "Height"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }

}
