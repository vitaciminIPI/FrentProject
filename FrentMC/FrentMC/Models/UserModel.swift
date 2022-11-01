//
//  UserModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 27/10/22.
//

import Foundation

struct Records: Codable {
    let fields: [User]
}

struct User: Codable {
    let user_id: String?
    let name: String?
    let phone_number: String?
    let email: String?
    let password: String?
    let nim: String?
    let university: String?
    let location: String?
    let student_card: String?
    let role_id: String?
    let created_at: String?
    let rent_orders: String?
}

class UserModels {
    var name: String
    var phone_number: String?
    var email: String
    var password: String
    var confirmPassword: String
    var nim: String?
    var university: String?
    var location: String?
    var student_card: String?
    
    init(name: String, phone_number: String?, email: String, password: String, confirmPassword: String, nim: String?, university: String?, location: String?, student_card: String?) {
        self.name = name
        self.phone_number = phone_number
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.nim = nim
        self.university = university
        self.location = location
        self.student_card = student_card
    }
    
//    func validateName() -> Bool {
//        if name == "" {
//            return false
//        }
//
//        if name.count < 5 || name.count > 30 {
//            return false
//        }
//
//        let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
//        let name = name.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
//
//        if !name {
//            return false
//        }
//
//        return true
//    }
//
//    func validateEmail() -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        return predicate.evaluate(with: email)
//    }
//
//    func isIdenticalPassword() -> Bool {
//        return password == confirmPassword
//    }
//
//    func validatePassword() -> Bool {
//        guard isIdenticalPassword() != false else {
//            return false
//        }
//        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        return predicate.evaluate(with: password)
//    }
    
}
