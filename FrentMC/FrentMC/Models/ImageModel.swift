//
//  ImageModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 09/11/22.
//

import Foundation

struct DataImage : Codable {
    var data: DataFields
    var success: Bool
    var status: Int
}

struct DataFields : Codable {
    var image: Image
    var url: String
}

struct Image : Codable {
    var name: String
    var url: String
}
