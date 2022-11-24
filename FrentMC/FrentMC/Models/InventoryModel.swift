//
//  InventoryModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 24/11/22.
//

import Foundation

struct DataFieldInventory: Codable {
    var id: String?
}

struct RecordInventory: Codable {
    var records: [DataFieldInventory]?
}
