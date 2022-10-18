//
//  RequestGoodsViewModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 18/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class RequestGoodsViewModel {
    var  requestGoods = PublishSubject<[RequestGoods]>()
    
    func fetchRequestGoods() {
        let goods = [
            RequestGoods(goodName: "Penggaris gamtek", userName: "Micah", univName: "Universitas Indonesia", majorName: "Ekonomi"),
            RequestGoods(goodName: "Buku teknik sipil II", userName: "Ismawan", univName: "Binus", majorName: "Teknik Sipil"),
            RequestGoods(goodName: "Tabung gambar", userName: "Daniel", univName: "Binus", majorName: "DKV"),
            RequestGoods(goodName: "Pengantar Fisika Dasar", userName: "Jonathan", univName: "Universitas Indonesia", majorName: "Teknik fisika"),
            RequestGoods(goodName: "Jas Laboratorium", userName: "Adela", univName: "Universitas Indonesia", majorName: "Biologi")
        ]
        
        requestGoods.onNext(goods)
        requestGoods.onCompleted()
    }
    
}
