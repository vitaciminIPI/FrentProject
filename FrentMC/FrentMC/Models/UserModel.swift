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
    var password: String?
    var email: String?
    var location: String?
    var created_at: String?
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
    
    init(user_id: String, name: String, phone_number: String?, email: String, password: String, confirmPassword: String, nim: String?, major: String?, entryYear: String?, university: String?, location: String?, student_card: String?) {
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
    }
    
    
    
}
