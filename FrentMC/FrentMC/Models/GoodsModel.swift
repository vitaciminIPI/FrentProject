//
//  GoodsModel.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/19/22.
//

import Foundation
import UIKit

struct Goods {
    var imageView: String?
    var goodsName: String?
    var univName: String?
    var location: String?
    var price: String?
    
    
    func initData() -> [Goods] {
        var goodsData = [Goods]()
        goodsData.append(Goods(imageView: "frentImage", goodsName: "barang 1", univName: "UT", location: "Tangerang", price: "Rp. 15,000" ))
        return goodsData
    }
}

struct RecordDisplayGood: Codable {
    var records: [DataFieldDisplayGood]?
}

struct DataFieldDisplayGood: Codable {
//    var id: String?
    var createdTime: String?
    var fields: DisplayGoods?
}

struct DisplayGoods: Codable {
    var image_goods: [DisplayGoodsImages]?
    var name: String?
    
    var university: [String]?
    var location: [String]?
    var major: String?
    var condition: String?
    
    var rent_first: String?
    var rent_second: String?
    var rent_third: String?
    var description: String?
    var user: [String]?
    
    enum CodingKeys: String, CodingKey{
        case image_goods = "image_goods"
        case name = "name"
        case university = "university (from user_id) (from role_id) (from owner_id) (from inventory_id)"
        case major = "major"
        case condition = "condition"
        case rent_first = "rent_first"
        case rent_second = "rent_second"
        case rent_third = "rent_third"
        case description = "description"
        
        case user = "name (from user_id) (from role_id) (from owner_id) (from inventory_id)"
        
        case location = "location (from user_id) (from role_id) (from owner_id) (from inventory_id)"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image_goods = try container.decodeIfPresent([DisplayGoodsImages].self, forKey: .image_goods)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.university = try container.decodeIfPresent([String].self, forKey: .university)
        self.major = try container.decodeIfPresent(String.self, forKey: .major)
        self.condition = try container.decodeIfPresent(String.self, forKey: .condition)
        self.rent_first = try container.decodeIfPresent(String.self, forKey: .rent_first)
        self.rent_second = try container.decodeIfPresent(String.self, forKey: .rent_second)
        self.rent_third = try container.decodeIfPresent(String.self, forKey: .rent_third)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.location = try container.decodeIfPresent([String].self, forKey: .location)
        self.user = try container.decodeIfPresent([String].self, forKey: .user)
    }
}

struct DisplayGoodsImages: Codable {
    let id: String?
    let size: Int?
    let url: String?
}

//MARK: -TESTER

//
