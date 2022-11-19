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
        goodsData.append(Goods(imageView: "frentImage", goodsName: "barang 2", univName: "Binus", location: "Tangerang", price: "Rp. 25,000" ))
        goodsData.append(Goods(imageView: "diamond_app_icon", goodsName: "barang 3", univName: "UI", location: "Tangerang", price: "Rp. Rp. 35,000" ))
        goodsData.append(Goods(imageView: "frentImage", goodsName: "barang 4", univName: "Unpad", location: "Tangerang", price: "Rp. 45,000" ))
        goodsData.append(Goods(imageView: "frentImage", goodsName: "barang 5", univName: "UMM", location: "Tangerang", price: "Rp. 65,000" ))
//        goodsData.append(Goods(imageView: "diamond_app_icon", goodsName: "barang 6", univName: "NJ", location: "Tangerang", price: "Rp. 65,000" ))
//        goodsData.append(Goods(imageView: "frentImage", goodsName: "barang 7", univName: "UB", location: "Tangerang", price: "Rp. 75,000" ))
//        goodsData.append(Goods(imageView: "frentImage", goodsName: "barang 8", univName: "Untar", location: "Tangerang", price: "Rp. 85,000" ))
//        goodsData.append(Goods(imageView: "diamond_app_icon", goodsName: "barang 9", univName: "Udayana", location: "Tangerang", price: "Rp. 95,000" ))
        
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
    
    var university: String?
    var location: [String]?
    var major: String?
    var condition: String?
    
    var rent_first: String?
    
    enum CodingKeys: String, CodingKey{
        case image_goods = "image_goods"
        case name = "name"
        case university = "university"
        case major = "major"
        case condition = "condition"
        case rent_first = "rent_first"
        
        case location = "location (from user_id) (from role_id) (from owner_id) (from inventory_id)"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image_goods = try container.decodeIfPresent([DisplayGoodsImages].self, forKey: .image_goods)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.university = try container.decodeIfPresent(String.self, forKey: .university)
        self.major = try container.decodeIfPresent(String.self, forKey: .major)
        self.condition = try container.decodeIfPresent(String.self, forKey: .condition)
        self.rent_first = try container.decodeIfPresent(String.self, forKey: .rent_first)
        self.location = try container.decodeIfPresent([String].self, forKey: .location)
    }
}

struct DisplayGoodsImages: Codable {
    let id: String?
    let size: Int?
    let url: String?
}

//MARK: -TESTER


