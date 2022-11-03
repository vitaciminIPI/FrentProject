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
