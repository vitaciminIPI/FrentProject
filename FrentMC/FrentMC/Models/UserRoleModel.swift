//
//  UserRoleModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 18/11/22.
//

import Foundation

struct DataFieldRole: Codable {
    var id: String?
}

struct RecordRole: Codable {
    var records: [DataFieldRole]?
}
