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
    var location: String?
    var major: String?
    var condition: String?
    
    var rent_first: String?
}

struct DisplayGoodsImages: Codable {
    let id: String?
    let size: Int?
    let url: String?
}
