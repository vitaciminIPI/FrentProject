//
//  GoodModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 11/10/22.
//

import Foundation

struct DisplayImage: Codable {
    var id: String?
    var size: Int?
    var url: String?
}

struct GoodOrders: Codable {
    var ownerName: [String]?
    var rent_date: String?
    var expired: String?
    var univ: [String]?
    var location: [String]?
    var category: [String]?
    var goodName: [String]?
    var image_goods: [DisplayImage]?
    
    enum CodingKeys: String, CodingKey {
        case ownerName = "name (from user_id) (from role_id) (from owner_id) (from inventory_id)"
        case univ = "university (from user_id) (from role_id) (from owner_id) (from inventory_id)"
        case location = "ocation (from user_id) (from role_id) (from owner_id) (from inventory_id)"
        case category = "category (from goods_id) (from inventory_id)"
        case goodName = "name (from goods_id) (from inventory_id)"
        case image_goods = "image_goods (from goods_id) (from inventory_id)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ownerName = try container.decodeIfPresent([String].self, forKey: .ownerName)
        self.univ = try container.decodeIfPresent([String].self, forKey: .univ)
        self.location = try container.decodeIfPresent([String].self, forKey: .location)
        self.category = try container.decodeIfPresent([String].self, forKey: .category)
        self.goodName = try container.decodeIfPresent([String].self, forKey: .goodName)
        self.image_goods = try container.decodeIfPresent([DisplayImage].self, forKey: .image_goods)
    }
    
}

struct DataFieldOrders: Codable {
    var id: String?
    var createdTime: String?
    var fields: GoodOrders?
}

struct RecordOrders: Codable {
    var records: [DataFieldOrders]?
}

struct Good {
    var goods_id: String
    var goodName: String
    var goodImage: String
    var location: String
    var univName: String
    var duration: String
    var status: String
    var timeStamp: String
    var condition: String
    var major: String
    var description: String
    var rentFirst: String
    var rentSecond: String
    var rentThird: String
}

class GoodModel {
    var goodName: String
    var goodImage: String
    var location: String
    var univName: String
    var duration: String
    var status: String
    var timeStamp: String
    var condition: String
    var major: String
    var description: String
    var rentFirst: String
    var rentSecond: String
    var rentThird: String
    
    init(goodName: String, goodImage: String, location: String, univName: String, duration: String, status: String, timeStamp: String, condition: String, major: String, description: String, rentFirst: String, rentSecond: String, rentThird: String) {
        self.goodName = goodName
        self.goodImage = goodImage
        self.location = location
        self.univName = univName
        self.duration = duration
        self.status = status
        self.timeStamp = timeStamp
        self.condition = condition
        self.major = major
        self.description = description
        self.rentFirst = rentFirst
        self.rentSecond = rentSecond
        self.rentThird = rentThird
    }
    
}
