//
//  GoodsModel2.swift
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
        goodsData.append(Goods(imageView: "1", goodsName: "barang 1", univName: "UT", location: "Tangerang", price: "15,000" ))
        goodsData.append(Goods(imageView: "2", goodsName: "barang 2", univName: "Binus", location: "Tangerang", price: "25,000" ))
        goodsData.append(Goods(imageView: "3", goodsName: "barang 3", univName: "UI", location: "Tangerang", price: "35,000" ))
        goodsData.append(Goods(imageView: "4", goodsName: "barang 4", univName: "Unpad", location: "Tangerang", price: "45,000" ))
        goodsData.append(Goods(imageView: "5", goodsName: "barang 5", univName: "UMM", location: "Tangerang", price: "65,000" ))
        goodsData.append(Goods(imageView: "6", goodsName: "barang 6", univName: "NJ", location: "Tangerang", price: "65,000" ))
        goodsData.append(Goods(imageView: "7", goodsName: "barang 7", univName: "UB", location: "Tangerang", price: "75,000" ))
        goodsData.append(Goods(imageView: "8", goodsName: "barang 8", univName: "Untar", location: "Tangerang", price: "85,000" ))
        goodsData.append(Goods(imageView: "9", goodsName: "barang 9", univName: "Udayana", location: "Tangerang", price: "95,000" ))
        
        return goodsData
    }
   
}

