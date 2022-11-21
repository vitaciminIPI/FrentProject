//
//  OwnerGoodModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 21/11/22.
//

import Foundation

/**
    1. Good name
    2. Location
    3. Univ
    4. Duration
    5. Status
    6. Good image
 **/

struct DisplayImageData: Codable {
    var id: String?
    var url: String?
}

struct OwnerGood: Codable {
    var goodId: String?
    var goodName: String?
    var location: [String]?
    var university: [String]?
    var expired: [String]?
    var isAvailable: Bool?
    var imageGood: [DisplayImageData]?
    
    enum CodingKeys: String, CodingKey {
        case goodId = "goods_id"
        case goodName = "name"
        case location = "location (from user_id) (from role_id) (from owner_id) (from inventory_id)"
        case university = "university (from user_id) (from role_id) (from owner_id) (from inventory_id)"
        case expired = "expired (from rent_id) (from inventory_id)"
        case imageGood = "image_goods"
        case isAvailable = "is_available"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.goodName = try container.decodeIfPresent(String.self, forKey: .goodName)
        self.location = try container.decodeIfPresent([String].self, forKey: .location)
        self.university = try container.decodeIfPresent([String].self, forKey: .university)
        self.expired = try container.decodeIfPresent([String].self, forKey: .expired)
        self.imageGood = try container.decodeIfPresent([DisplayImageData].self, forKey: .imageGood)
        self.isAvailable = try container.decodeIfPresent(Bool.self, forKey: .isAvailable)
        self.goodId = try container.decodeIfPresent(String.self, forKey: .goodId)
    }
    
}

struct DataFieldOwner: Codable {
    var id: String?
    var createdTime: String?
    var fields: OwnerGood?
}

struct OwnerGoodRecord: Codable {
    var records: [DataFieldOwner]?
}
