//
//  HistoryModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 20/11/22.
//

import Foundation

struct DisplayImageHistory: Codable {
    var id: String?
    var size: Int?
    var url: String?
}

struct History: Codable {
    var historyId: String?
    var expired: [String]?
    var goodName: [String]?
    var ownerName: [String]?
    var location: [String]?
    var university: [String]?
    var imageGood: [DisplayImageHistory]?
    
    enum CodingKeys: String, CodingKey {
        case expired = "expired (from rent_id)"
        case goodName = "name (from goods_id) (from inventory_id) (from rent_id)"
        case ownerName = "name (from user_id) (from role_id) (from owner_id) (from inventory_id) (from rent_id)"
        case location = "location (from user_id) (from role_id) (from owner_id) (from inventory_id) (from rent_id)"
        case university = "university (from user_id) (from role_id) (from owner_id) (from inventory_id) (from rent_id)"
        case historyId = "history_id"
        case imageGood = "image_goods (from goods_id) (from inventory_id) (from rent_id)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.expired = try container.decodeIfPresent([String].self, forKey: .expired)
        self.goodName = try container.decodeIfPresent([String].self, forKey: .goodName)
        self.ownerName = try container.decodeIfPresent([String].self, forKey: .ownerName)
        self.location = try container.decodeIfPresent([String].self, forKey: .location)
        self.university = try container.decodeIfPresent([String].self, forKey: .university)
        self.historyId = try container.decodeIfPresent(String.self, forKey: .historyId)
        self.imageGood = try container.decodeIfPresent([DisplayImageHistory].self, forKey: .imageGood)
    }
    
}

struct DataFieldHistory: Codable {
    var id: String?
    var createdTime: String?
    var fields: History?
}

struct RecordHistory: Codable {
    var records: [DataFieldHistory]?
}
