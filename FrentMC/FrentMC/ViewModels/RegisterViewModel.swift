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
    typealias authenticationProfileOneCallBack = (_ status: Bool, _ message: String) -> Void
    
    var registerCallback: authenticationRegisterCallBack?
    var profileOneCallBack: authenticationProfileOneCallBack?
    var userModel: UserModels!
    
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
            userModel = UserModels(user_id: getUserId(), name: name, phone_number: "", email: email, password: hashFunction(password: password), confirmPassword: confirmPassword, nim: "", entryYear: "", university: "", location: "", student_card: "")
            save(user: userModel)
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
    
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        if phoneNumber == "" {
            return false
        }
        let expression = "^\\+[1-9]{1}[0-9]{3,14}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", expression)
        return predicate.evaluate(with: phoneNumber)
    }
    
    func validateEntryYear(year: String) -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        guard let intYear = Int(year) else {return false}
        
        if year == "" {
            return false
        }
        else if intYear < 1990 {
            return false
        }
        else if intYear > currentYear {
            return false
        }
        return true
    }
    
    func validateLocation(location: String) -> Bool {
        if location == "" {
            return false
        }
        else if location.count < 3 || location.count > 20 {
            return false
        }
        return true
    }
    
    func authenticateUserProfileOne(phoneNumber: String, year: String, location: String) {
        let isValidNumber = validatePhoneNumber(phoneNumber: phoneNumber)
        let isValidYear = validateEntryYear(year: year)
        let isValidLocation = validateLocation(location: location)
        
        print(isValidNumber)
        print(isValidYear)
        print(isValidLocation)
        
        if !isValidNumber {
            print("salah")
            self.profileOneCallBack?(false, "Invalid phone number")
        }
        else if !isValidYear {
            print("salah")
            self.profileOneCallBack?(false, "Invalid entry year")
        }
        else if !isValidLocation {
            print("salah")
            self.profileOneCallBack?(false, "Invalid location")
        }
        else {
            //UDAH FIX TAPI BELUM FETCH DATA REAL
//            let strYear = String(phoneNumber)
//            userModel.phone_number = phoneNumber
//            userModel.entryYear = strYear
//            userModel.location = location
            self.profileOneCallBack?(true, "Data valid")
        }
    }
    
    func profileOneCompletionHandler(callback: @escaping authenticationProfileOneCallBack) {
        self.profileOneCallBack = callback
    }
    
    func save (user: UserModels) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user") else {return}
        let userId = user.user_id
        let userName = user.name
        let userEmail = user.email
        let password = user.password
        
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
