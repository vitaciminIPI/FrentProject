//
//  AddStuffViewModel.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 11/2/22.
//

import Foundation
import UIKit
import CryptoKit

import RxSwift
import RxCocoa

class AddStuffViewModel {
    
    let displayGoods = BehaviorRelay<[DataFieldDisplayGood]>(value: [])
    let displayGoods2 = BehaviorRelay<[DataFieldDisplayGood]>(value: [])
    let displayGoods3 = BehaviorRelay<[DataFieldDisplayGood]>(value: [])
    
//    let displayGoodsInside = BehaviorRelay<[DataFieldDisplayGood]>(value: [])
//
//    init(displayGoodsInside: String){
//        self.displayGoodsInside = .init(value: [])
//    }
    
    //MARK: - authentication
    typealias authenticationRegisterCallBack = (_ status: Bool, _ message: String) -> Void
    var registerCallback: authenticationRegisterCallBack?
    var good: Good!
    
    func registerCompletionHandler(callBack: @escaping authenticationRegisterCallBack) {
        self.registerCallback = callBack
    }
    
    //MARK: - validate nama barang
    func validateNamaBarang(goodName: String) -> Bool {
        if goodName == "" {
            return false
        }
        
        if goodName.count < 3 || goodName.count > 30 {
            return false
        }
        
        let lettersAndSpacesCharacterSet = CharacterSet.letters.union(.whitespaces).inverted
        let goodName = goodName.rangeOfCharacter(from: lettersAndSpacesCharacterSet) == nil
        
        if !goodName {
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
    
    //MARK: - VALIDATE Harga sewa 1
    func validateSewa1(rentFirst: String) -> Bool {
        if rentFirst == "" {
            return false
        }
        
        if rentFirst.count < 5 || rentFirst.count > 30 {
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
        return true
    }
    
    //MARK: - GETGoodsId
    func getGoodsId() -> String {
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
    
    
    //MARK: - VALIDATE STUFF DATA
    
    func authenticateStuffData(goodName: String, condition:String, major: String, description: String, rentFirst: String, rentSecond: String, rentThird: String){
        let isValidName = validateNamaBarang(goodName: goodName)
        let isValidCondition = validateKondisiBarang(condition: condition)
        let isValidMajor = validateJurusan(major: major)
        let isValidDescription = validateDeskripsi(description: description)
        
        let isValidRentFirst = validateSewa1(rentFirst: rentFirst)
        let isValidRentSecond = validateSewa1(rentFirst: rentSecond)
        let isValidRentThird = validateSewa1(rentFirst: rentThird)
        
        if !isValidName {
            print("salah")
            self.registerCallback?(false, "invalid Name")
        }
        else if !isValidCondition {
            print("salah")
            self.registerCallback?(false, "invalid Condition")
        }
        else if !isValidMajor {
            print("salah")
            self.registerCallback?(false, "invalid Major")
        }
        else if !isValidDescription {
            print("salah")
            self.registerCallback?(false, "invalid Description")
        }
        else if !isValidRentFirst {
            print("salah")
            self.registerCallback?(false, "invalid price 1")
        }
        else if !isValidRentSecond {
            print("salah")
            self.registerCallback?(false, "invalid Price 2")
        }
        else if !isValidRentThird {
            print("salah")
            self.registerCallback?(false, "invalid Price 3")
        }
        else {
            //            good = Good(goods_id: "\(getGoodsId())", goodName:goodName, goodImage:"", location: "", univName: "", duration: "", status: "", timeStamp: "", condition:condition, major:major, description: description, rentFirst:rentFirst, rentSecond:rentSecond, rentThird:rentThird)
            //            save(good: good)
            self.registerCallback?(true, "Valid Data")
        }
    }
    
    func getOwnerId(id: String, ownerId: @escaping (String)-> Void) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/owner?filterByForumula=%7Bowner_id%7D=%22\(id)%22&fields%5B%5D=owner_id") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                print("something wrong")
                return
            }
            
            do {
                let resp = try JSONDecoder().decode(RecordsOwnerRole.self, from: data)
                guard let ownId = resp.records?[0].id else {return}
                ownerId(ownId)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    func createInventory(ownerId: String, inventId: @escaping (String)-> Void) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/inventory") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
//        self.getOwnerId(id: ownerId) { id in
//
//        }
        let data: [String: AnyHashable] = [
            "owner_id" : [ownerId],
        ]
        
        let fields: [String: AnyHashable] = [
            "fields" : data
        ]
        
        let records: [String: AnyHashable] = [
            "records" : [fields]
        ]
        
        do {
            let body = try JSONSerialization.data(withJSONObject: records)
            request.httpBody = body
        } catch {
            print("failed to convert")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                print("something wrong")
                return
            }
            
            do {
//                    let resp = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(resp)
                let resp = try JSONDecoder().decode(RecordInventory.self, from: data)
                guard let inventoryId = resp.records?[0].id else {return}
                inventId(inventoryId)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    
    func save (good: Good, owner_id: [String], image: UIImage) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods") else {return}
        
        //        let imageGoods = good.goodImage
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
        
        
        
        let apiManager = APICaller()
        
        apiManager.uploadImage (image: image) { url in
            print("url : \(url)")
            let imagesData : [String: AnyHashable] = [
                "url" : url
            ]
            
            self.createInventory(ownerId: owner_id[0]) { inventId in
                let goodFields: [String: AnyHashable] = [
                        "is_available" : true,
                        "inventory_id" : [inventId],
                        "image_goods" : [imagesData],
                        "name"   : "\(namaBarang)",
                        "condition"      : "\(kondisiBarang)",
                        "major"     : "\(jurusan)",
                        "description"  : "\(description)",
                        "rent_first"  : "\(sewa1)",
                        "rent_second"  : "\(sewa2)",
                        "rent_third"  : "\(sewa3)",
                ]
                let dataFields: [String : AnyHashable] = [
                    "fields" : goodFields
                ]
                
                let goodDataRaw: [String: AnyHashable] = [
                    "records": [dataFields]
                ]
                
                do {
                    let bodyRequest = try
                    JSONSerialization.data(withJSONObject: goodDataRaw, options: .fragmentsAllowed)
                    request.httpBody = bodyRequest
                } catch {
                    print("error")
                }
                
                let taskGood = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {return}
                    
                    do{
                        let _ = try
                        JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
    //                    print(response)
                    } catch {
                        print("error parsing")
                    }
                }
                taskGood.resume()
            }
            
            
        }
        
    }
        
        //MARK: - display goods 1
        func fetchDisplayGoods(){
            guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods") else {return}
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
            let headers = [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer key5mYI0C1rXukR8H"
            ]
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let task = URLSession.shared.dataTask(with: request) { (data, _, err) in
                guard let data = data, err == nil else {
                    print("error ni")
                    return
                }
                do {
                    let resp = try JSONDecoder().decode(RecordDisplayGood.self, from: data)
//                    print(resp)
                    self.displayGoods.accept(resp.records!)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    
    
        
        //MARK: - display goods 2
    func fetchDisplayGoods2(user: UserModels){
//            let space = user.major
//            let newSpace = space?.replacingOccurrences(of: " ", with: "%20")
            
//            guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods?filterByFormula=%7Bmajor%7D=%22\(newSpace ?? "0")%22") else {return}
            guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods?filterByFormula=%7Bmajor%7D=%22Teknik%20Informatika%22") else {return}
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
            let headers = [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer key5mYI0C1rXukR8H"
            ]
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let task = URLSession.shared.dataTask(with: request) { (data, _, err) in
                guard let data = data, err == nil else {
                    print("error ni")
                    return
                }
                do {
                    let resp = try JSONDecoder().decode(RecordDisplayGood.self, from: data)
//                    print(resp)
                    self.displayGoods2.accept(resp.records!)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
        //MARK: - display goods 3
    
        func fetchDisplayGoods3(){
            guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods?filterByFormula=%7Blocation%20%28from%20user_id%29%20%28from%20role_id%29%20%28from%20owner_id%29%20%28from%20inventory_id%29%7D=%22jakarta%22") else {return}
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
            let headers = [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer key5mYI0C1rXukR8H"
            ]
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let task = URLSession.shared.dataTask(with: request) { (data, _, err) in
                guard let data = data, err == nil else {
                    print("error ni")
                    return
                }
                do {
                    let resp = try JSONDecoder().decode(RecordDisplayGood.self, from: data)
//                    print(resp)
                    self.displayGoods3.accept(resp.records!)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
}
