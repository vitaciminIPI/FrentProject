//
//  RequestGoodModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 18/10/22.
//

import Foundation

struct RecordRGood: Codable {
    var records: [DataFieldRGood]?
}

struct DataFieldRGood: Codable {
    var id: String?
    var createdTime: String?
    var fields: RequestGoods?
}

struct RequestGoods: Codable {
    var request_goods: String?
    var name: String?
    var university: String?
    var major: String?
    var phone_number: String?
}
