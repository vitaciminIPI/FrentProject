//
//  RegisterViewModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 30/10/22.
//

import Foundation
import UIKit
import CryptoKit

class RegisterViewModel {
    
    typealias authenticationRegisterCallBack = (_ status: Bool, _ message: String) -> Void
    typealias authenticationProfileTwoCallBack = (_ status: Bool, _ message: String) -> Void
    var registerCallback: authenticationRegisterCallBack?
    var profileTwoCallback: authenticationProfileTwoCallBack?
    var user: User!
    
    func validateName(name: String) -> Bool {
        if name == "" {
            return false
        }
        
        if name.count < 5 || name.count > 30 {
            return false
        }
        
        let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
        let name = name.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
        
        if !name {
            return false
        }
        
        return true
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    func isIdenticalPassword(password: String, confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
    func validatePassword(password: String, confirmPassword: String) -> Bool {
        guard isIdenticalPassword(password: password, confirmPassword: confirmPassword) != false else {
            return false
        }
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
    
    func authenticateUserData(name: String, email: String, password: String, confirmPassword: String) {
        let isValidName = validateName(name: name)
        let isValidEmail = validateEmail(email: email)
        let isValidPassword = validatePassword(password: password, confirmPassword: confirmPassword)
        
        if !isValidName {
            print("salah")
            self.registerCallback?(false, "Invalid Name")
//            print(registerCallback)
        }
        else if !isValidEmail {
            print("salah")
            self.registerCallback?(false, "Invalid Email")
        }
        else if !isValidPassword {
            print("salah")
            self.registerCallback?(false, "Invalid Password")
        }
        else {
            user = User(user_id: "\(getUserId())", name: name, phone_number: "", email: email, password: hashFunction(password: password), nim: "", university: "", location: "", student_card: "", role_id: "", created_at: "", rent_orders: "")
            save(user: user)
            self.registerCallback?(true, "Valid Data")
        }
    }
    
    func registerCompletionHandler(callBack: @escaping authenticationRegisterCallBack) {
        self.registerCallback = callBack
    }
    
    func hashFunction(password: String) -> String {
        let data = Data(password.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap {String(format: "%02x", $0)}.joined()
        return hash
    }
    
    func getUserId() -> String {
        var str = "USR-"
        let randInt = Int.random(in: 3...999)
        
        if randInt/10 < 1 && randInt/10 < 10 {
            str += "00\(randInt)"
        }
        else if randInt/100 < 1 && randInt/100 < 10 {
            str += "0\(randInt)"
        }
        else {
            str += "\(randInt)"
        }

        return str
    }
    
    func validateUniversity(university: String) -> Bool {
        if university == "" {
            return false
        }
        else if university.count < 2 || university.count > 10 {
            return false
        }
        
        return true
    }
    
    func validateMajor(major: String) -> Bool {
        if major == "" {
            return false
        }
        else if major.count < 5 || major.count > 10 {
            return false
        }
        return true
    }
    
    func validateStudentId(nim: String) -> Bool {
        if nim == "" {
            return false
        }
        else if nim.count < 7 || nim.count > 10 {
            return false
        }
        return true
    }
    
    func validateImage(image: String) -> Bool {
        if image == "" {
            return false
        }
        else if image.count > 100000 {
            return false
        }
        return true
    }
    
    func imageEncode(imgView: UIImageView) -> String {
        let imgString = imgView.image?.pngData()?.base64EncodedString(options: .lineLength64Characters)
        return imgString ?? ""
    }
    
    func authenticateProfileTwo(univ: String, major: String, nim: String, image: String) {
        let isValidUniv = validateUniversity(university: univ)
        let isValidMajor = validateMajor(major: major)
        let isvValidNim = validateStudentId(nim: nim)
        let isValidImage = validateImage(image: image)
        
        if !isValidUniv {
            self.profileTwoCallback?(false, "Invalid University")
        }
        else if !isValidMajor {
            self.profileTwoCallback?(false, "Invalid Major")
        }
        else if !isvValidNim {
            self.profileTwoCallback?(false, "Invalid NIM")
        }
        else if !isValidImage {
            self.profileTwoCallback?(false, "Invalid Image")
        }
        else {
            self.profileTwoCallback?(true, "Valid data")
        }
    }
    
    func profileTwoCompletionHandler(callback: @escaping authenticationProfileTwoCallBack) {
        self.profileTwoCallback = callback
    }
    
    func save (user: User) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user") else {return}
        guard let userId = user.user_id else {return}
        guard let userName = user.name else {return}
        guard let userEmail = user.email else {return}
        guard let password = user.password else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        request.allHTTPHeaderFields = headers
        let userFields: [String: AnyHashable] = [
            "fields": [
                "user_id"   : "\(userId)",
                "name"      : "\(userName)",
                "email"     : "\(userEmail)",
                "password"  : "\(password)"
            ]
        ]
        let userDataRaw: [String: AnyHashable] = [
            "records": [userFields]
        ]
        
        print("Saving the use data to Database")
        
        do {
            let bodyRequest = try JSONSerialization.data(withJSONObject: userDataRaw, options: .fragmentsAllowed)
            request.httpBody = bodyRequest
        } catch {
            print("Error parsing")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(response)
            } catch {
                print("Parsing error")
            }
        }
        task.resume()
    }
    
}
