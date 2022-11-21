//
//  RegisterViewModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 30/10/22.
//

import Foundation
import UIKit
import CryptoKit
import RxSwift
import RxCocoa

class RegisterViewModel {
    
    typealias authenticationRegisterCallBack = (_ status: Bool, _ message: String) -> Void
    typealias authenticationProfileOneCallBack = (_ status: Bool, _ message: String) -> Void
    typealias authenticationProfileTwoCallBack = (_ status: Bool, _ message: String) -> Void
    
    private var registerCallback: authenticationRegisterCallBack?
    var profileOneCallBack: authenticationProfileOneCallBack?
    var profileTwoCallback: authenticationProfileTwoCallBack?

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
    
    func hashFunction(password: String) -> String {
        let data = Data(password.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap {String(format: "%02x", $0)}.joined()
        return hash
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
        else if major.count < 2 || major.count > 20 {
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
    
    func getBase64(image: UIImage, complete: @escaping (String?) -> Void) {
        DispatchQueue.main.async {
            let imageData = image.jpegData(compressionQuality: 0.2)
            let base64 = imageData?.base64EncodedString(options: .lineLength64Characters)
            complete(base64)
        }
    }
    
    func profileTwoCompletionHandler(callback: @escaping authenticationProfileTwoCallBack) {
        self.profileTwoCallback = callback
    }
    
    func profileOneCompletionHandler(callback: @escaping authenticationProfileOneCallBack) {
        self.profileOneCallBack = callback
    }
    
    func registerCompletionHandler(callBack: @escaping authenticationRegisterCallBack) {
        self.registerCallback = callBack
    }
    
    func authenticateUserProfileOne(phoneNumber: String, year: String, location: String) {
        let isValidNumber = validatePhoneNumber(phoneNumber: phoneNumber)
        let isValidYear = validateEntryYear(year: year)
        let isValidLocation = validateLocation(location: location)
        
        if !isValidNumber {
            self.profileOneCallBack?(false, "Invalid phone number")
        }
        else if !isValidYear {
            self.profileOneCallBack?(false, "Invalid entry year")
        }
        else if !isValidLocation {
            self.profileOneCallBack?(false, "Invalid location")
        }
        else {
            self.profileOneCallBack?(true, "Data valid")
        }
    }
    
    func authenticateProfileTwo(univ: String, major: String, nim: String, image: UIImage) {
        let isValidUniv = validateUniversity(university: univ)
        let isValidMajor = validateMajor(major: major)
        let isvValidNim = validateStudentId(nim: nim)
        
        if !isValidUniv {
            self.profileTwoCallback?(false, "Invalid University")
        }
        else if !isValidMajor {
            self.profileTwoCallback?(false, "Invalid Major")
        }
        else if !isvValidNim {
            self.profileTwoCallback?(false, "Invalid NIM")
        }
        else {
            self.profileTwoCallback?(true, "Valid data")
        }
    }
    
    func authenticateUserData(name: String, email: String, password: String, confirmPassword: String) {
        let isValidName = validateName(name: name)
        let isValidEmail = validateEmail(email: email)
        let isValidPassword = validatePassword(password: password, confirmPassword: confirmPassword)
        
        if !isValidName {
            self.registerCallback?(false, "Invalid Name")
        }
        else if !isValidEmail {
            self.registerCallback?(false, "Invalid Email")
        }
        else if !isValidPassword {
            self.registerCallback?(false, "Invalid Password")
        }
        else {
            self.registerCallback?(true, "Valid Data")
        }
    }
    
}
