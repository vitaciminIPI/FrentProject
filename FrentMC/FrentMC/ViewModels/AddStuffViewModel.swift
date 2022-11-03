//
//  AddStuffViewModel.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 11/2/22.
//

import Foundation
import UIKit
import CryptoKit

class AddStuffViewModel {

//    func decodeImage(base64: String) -> UIImage {
//            let dataDecoded: Data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters)!
//            let decodedImage = UIImage(data: dataDecoded)!
//            return decodedImage
//        }

//        func encodeImage() -> String {
//            let imgString = imgView.image?.pngData()?.base64EncodedString(options: .lineLength64Characters)
//            print(imgString ?? "")
//            return imgString ?? ""
//        }
    typealias authenticationRegisterCallBack = (_ status: Bool, _ message: String) -> Void
    var registerCallback: authenticationRegisterCallBack?
    var good: Good!
    
    //MARK: - validate nama barang
func validateNamaBarang(name: String) -> Bool {
    if name == "" {
        return false
    }
    
    if name.count < 3 || name.count > 30 {
        return false
    }
    
    let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
    let name = name.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
    
    if !name {
        return false
    }
    
    return true
}
    
    //MARK: - validate kondisi barang
func validateKondisiBarang(condition: String) -> Bool {
    if condition == "" {
        return false
    }
    
    if condition.count < 3 || condition.count > 30 {
        return false
    }
    
    let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
    let condition = condition.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
    
    if !condition {
        return false
    }
    
    return true
}
    
    
    //MARK: - validate jurusan
func validateJurusan(major: String) -> Bool {
    if major == "" {
        return false
    }
    
    if major.count < 1 || major.count > 30 {
        return false
    }
    
    let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
    let major = major.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
    
    if !major {
        return false
    }
    
    return true
}

    //MARK: - validate description
func validateDeskripsi(description: String) -> Bool {
    if description == "" {
        return false
    }
    
    if description.count < 5 || description.count > 100 {
        return false
    }
    
    let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
    let description = description.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
    
    if !description {
        return false
    }
    
    return true
}
}
    
    //MARK: - VALIDATE Harga sewa 1
func validateSewa1(rentFirst: String) -> Bool {
    if rentFirst == "" {
        return false
    }

    if rentFirst.count < 5 || rentFirst.count > 30 {
        return false
    }

    let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
    let rentFirst = rentFirst.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil

    if !rentFirst {
        return false
    }

    return true
}
    
    //MARK: - VALIDATE Harga sewa 2
func validateSewa2(rentSecond: String) -> Bool {
    if rentSecond == "" {
        return false
    }

    if rentSecond.count < 5 || rentSecond.count > 30 {
        return false
    }

    let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
    let rentSecond = rentSecond.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil

    if !rentSecond {
        return false
    }

        return true
    }

//MARK: - VALIDATE Harga sewa 3
func validateSewa3(rentThird: String) -> Bool {
    if rentThird == "" {
        return false
    }

    if rentThird.count < 5 || rentThird.count > 30 {
        return false
    }

    let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
    let rentThird = rentThird.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil

    if !rentThird {
        return false
    }

        return true
    }

    //MARK: - VALIDATE STUFF DATA

func authenticateStuffData(name: String, condition:String, major: String, description: String, rentFirst: String, rentSecond: String, rentThird: String){
//    let isValidName = validateNamaBarang(name: name)
//    let isValidCondition = validateKondisiBarang(condition: condition)
//    let isValidMajor = validateJurusan(major: major)
//    let isValidDescription = validateDeskripsi(description: description)
//    let isValidName = validateNamaBarang(name: name)

    let isValidRentFirst = validateSewa1(rentFirst: rentFirst)
    let isValidRentSecond = validateSewa1(rentFirst: rentSecond)
    let isValidRentThird = validateSewa1(rentFirst: rentThird)
    }
    


    func save (good: Good) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/inventory") else {return}
//        guard let userId = user.user_id else {return}
//        guard let userName = user.name else {return}
//        guard let userEmail = user.email else {return}
//        guard let password = user.password else {return}
        let namaBarang = good.goodName
        let kondisiBarang = good.condition
        let jurusan = good.major
        let description = good.description
        let sewa1 = good.rentFirst
        let sewa2 = good.rentSecond
        let sewa3 = good.rentThird
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer key5mYI0C1rXukR8H"
        ]
        request.allHTTPHeaderFields = headers
        let userFields: [String: AnyHashable] = [
            "fields": [
                "nama"   : "\(namaBarang)",
                "kondisi"      : "\(kondisiBarang)",
                "jurusan"     : "\(jurusan)",
                "desc"  : "\(description)",
                "sewa1"  : "\(sewa1)",
                "sewa1"  : "\(sewa2)",
                "sewa1"  : "\(sewa3)",
            ]
        ]
        let _: [String: AnyHashable] = [
            "records": [userFields]
        ]
    }

