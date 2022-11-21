//
//  ProfileViewModel.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 11/8/22.
//

import Foundation
import UIKit
import CryptoKit

class ProfileViewModel {
    
    //MARK: - AUTHENTICATIONPROFILE
    typealias authenticationRegisterCallBack = (_ status: Bool, _ message: String) -> Void
    
    typealias authenticationProfileCallBack = (_ status: Bool, _ message: String) -> Void
    
    var registerCallback: authenticationRegisterCallBack?
    var profileCallBack: authenticationProfileCallBack?
    var userModel: UserModels!
    
    
    
//    func registerCompletionHandler(callBack: @escaping authenticationProfileCallBack) {
//        self.profileCallBack = callBack
//    }
    
    //MARK: - VALIDATE EMAIL
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    //MARK: - VALIDATE WA NUMBER
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        if phoneNumber == "" {
            return false
        }
        let expression = "^\\+[1-9]{1}[0-9]{3,14}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", expression)
        return predicate.evaluate(with: phoneNumber)
    }

        //MARK: - VALIDATE NIM NUMBER
    func validateStudentId(nim: String) -> Bool {
        if nim == "" {
            return false
        }
        else if nim.count < 7 || nim.count > 10 {
            return false
        }
        return true
    }
        
    //MARK: - VALIDATE UNIVERSITAS
    func validateUniversitas(university: String) -> Bool {
        if university == "" {
            return false
        }
        
        if university.count < 5 || university.count > 30 {
            return false
        }
        
        let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
        let university = university.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
        
        if !university {
            return false
        }
        
        return true
    }
        
    //MARK: - VALIDATE LOKASI
    func validateLokasi(location: String) -> Bool {
        if location == "" {
            return false
        }
        
        if location.count < 3 || location.count > 30 {
            return false
        }
        
        let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
        let location = location.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
        
        if !location {
            return false
        }
        
        return true
    }
    
    //MARK: - VALIDATE BARANG PEMINATAN
    func validateBarangPeminatan(request_goods: String) -> Bool {
        if request_goods == "" {
            return false
        }
        
        if request_goods.count < 5 || request_goods.count > 30 {
            return false
        }
        
        let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
        let request_goods = request_goods.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
        
        if !request_goods {
            return false
        }
        
        return true
    }
    
    //MARK: - authentucate
    func authenticateUserProfile(email: String, phoneNumber: String, nimNumber: String, university: String, location: String , request_goods: String ) {
        
        let isValidEmail = validateEmail(email: email)
        let isValidPhoneNumber = validatePhoneNumber(phoneNumber: phoneNumber)
        let isValidStuentId = validateStudentId(nim: nimNumber)
        let isValidUniversity = validateUniversitas(university: university)
        let isValidLocation = validateLokasi(location: location)
        let isValidRequestGoods = validateBarangPeminatan(request_goods: request_goods)
        
        print(isValidEmail)
        print(isValidPhoneNumber)
        print(isValidStuentId)
        print(isValidUniversity)
        print(isValidLocation)
        print(isValidRequestGoods)
        
        if !isValidEmail{
            print("salah")
            self.profileCallBack?(false, "Invalid email")
        }
        else if !isValidPhoneNumber {
            print("salah")
            self.profileCallBack?(false, "Invalid phone number")
        }
        else if !isValidStuentId {
            print("salah")
            self.profileCallBack?(false, "Invalid nim number")
        }
        else if !isValidUniversity {
            print("salah")
            self.profileCallBack?(false, "Invalid university")
        }
        else if !isValidLocation {
            print("salah")
            self.profileCallBack?(false, "Invalid location")
        }
        else if !isValidRequestGoods {
            print("salah")
            self.profileCallBack?(false, "Invalid request goods")
        }
        
        else {
            userModel = UserModels(user_id: "", name: "", phone_number: phoneNumber, email: email, password: "", confirmPassword: "", nim: nimNumber, major: "", entryYear: "", university: university, location: location, student_card: "", request_goods: request_goods)
            patch(user: userModel)
            self.profileCallBack?(true, "Valid Data")
        }
    }
        
        func profileCompletionHandler(callback: @escaping authenticationProfileCallBack) {
            self.profileCallBack = callback
        }
        
//        func registerCompletionHandler(callBack: @escaping authenticationRegisterCallBack) {
//            self.registerCallback = callBack
//        }
        
        func patch (user: UserModels){
            guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user") else {return}
            
            let userEmail = user.email
            let phone_number = user.phone_number
            let nim = user.nim
            let university = user.university
            let location = user.location
            let request_goods = user.request_goods
            let api = APICaller()
            
            
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "PATCH"
            let headers = [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer key5mYI0C1rXukR8H"
            ]
            request.allHTTPHeaderFields = headers
            
            api.getUserRecordId(email: userEmail) { recordId in
            let userFields: [String: AnyHashable] = [
                "email"             : userEmail,
                "phone_number"      : phone_number,
                "nim"               : nim,
                "university"        : university,
                "location"          : location,
                "request_goods"     : request_goods
            ]
            
            let dataField: [String: AnyHashable] = [
                "id": recordId,
                "fields": userFields
            ]
            
            let records: [String : AnyHashable] = [
                "records": [dataField]
            ]
            
            do {
                let body = try JSONSerialization.data(withJSONObject: records, options: .fragmentsAllowed)
                request.httpBody = body
            } catch {
                print("Error parsing")
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {return}
                
                do {
                    let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(response)
                } catch {
                    print("Error")
                }
                
            }
            task.resume()
            
        }
    }
}

