//
//  UserModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 27/10/22.
//

import Foundation

struct Record: Codable {
    var records: [DataField]?
}

struct DataField: Codable {
    var id: String?
    var createdTime: String? 
    var fields: User?
}

struct User: Codable {
    var university: String?
    var rent_orders: [String]?
    var user_id: String?
    var nim: String?
    var phone_number: String?
    var role_id: [String]?
    var name: String?
    var major: String?
    var entry_year: String?
    var password: String?
    var email: String?
    var location: String?
    var created_at: String?
    var request_goods: String?
    var owner_id: [String]?
    
    enum CodingKeys: String, CodingKey {
        case owner_id = "owner_id (from role_id)"
        case university = "university"
        case rent_orders = "rent_orders"
        case user_id = "user_id"
        case nim = "nim"
        case phone_number = "phone_number"
        case role_id = "role_id"
        case name = "name"
        case major = "major"
        case entry_year = "entry_year"
        case password = "password"
        case email = "email"
        case location = "location"
        case created_at = "created_at"
        case request_goods = "request_goods"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.owner_id = try container.decode([String].self, forKey: .owner_id)
        self.university = try container.decodeIfPresent(String.self, forKey: .university)
        self.rent_orders = try container.decodeIfPresent([String].self, forKey: .rent_orders)
        self.user_id = try container.decodeIfPresent(String.self, forKey: .user_id)
        self.nim = try container.decodeIfPresent(String.self, forKey: .nim)
        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        self.role_id = try container.decodeIfPresent([String].self, forKey: .role_id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.major = try container.decodeIfPresent(String.self, forKey: .major)
        self.entry_year = try container.decodeIfPresent(String.self, forKey: .entry_year)
        self.password = try container.decodeIfPresent(String.self, forKey: .password)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.request_goods = try container.decodeIfPresent(String.self, forKey: .request_goods)
    }
    
}

class UserModels {
    var user_id: String
    var name: String
    var phone_number: String?
    var email: String
    var password: String
    var confirmPassword: String
    var nim: String?
    var major: String?
    var entryYear: String?
    var university: String?
    var location: String?
    var student_card: String?
    var request_goods: String?
    var owner_id: [String]?
    
    init(user_id: String, name: String, phone_number: String?, email: String, password: String, confirmPassword: String, nim: String?, major: String?, entryYear: String?, university: String?, location: String?, student_card: String?, request_goods: String, owner_id: [String]?) {
        self.user_id = user_id
        self.name = name
        self.phone_number = phone_number
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.nim = nim
        self.entryYear = entryYear
        self.university = university
        self.location = location
        self.student_card = student_card
        self.request_goods = request_goods
        self.owner_id = owner_id
    }
    
    
    
}
