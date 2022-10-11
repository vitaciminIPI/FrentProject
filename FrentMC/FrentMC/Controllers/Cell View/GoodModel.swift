//
//  GoodModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 11/10/22.
//

import Foundation

struct Good {
    var goodName: String
    var goodImage: String
    var location: String
    var univName: String
    var duration: String
    var status: String
}

class GoodModel {
    var goodName: String
    var goodImage: String
    var location: String
    var univName: String
    var duration: String
    var status: String
    
    init(goodName: String, goodImage: String, location: String, univName: String, duration: String, status: String) {
        self.goodName = goodName
        self.goodImage = goodImage
        self.location = location
        self.univName = univName
        self.duration = duration
        self.status = status
    }
    
}
