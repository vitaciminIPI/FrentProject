//
//  LentGoodsViewModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 21/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class LentGoodsViewModel {
    
    let ownerGoods = BehaviorRelay<[DataFieldOwner]>(value: [])
    
    func getAllOwnerGoods() {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                print("somethings wrong")
                return
            }
            
            do {
                let resp = try JSONDecoder().decode(OwnerGoodRecord.self, from: data)
                self.ownerGoods.accept(resp.records!)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
    func getRecordId(goodId: String, completion: @escaping (String)-> Void) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods?filterByFormula=%7Bgoods_id%7D=%22GDS-0004%22") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {return}
            
            do {
                let resp = try JSONDecoder().decode(OwnerGoodRecord.self, from: data)
                completion(resp.records?[0].id ?? "")
//                print(resp.records?[0].id ?? "")
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    /*
     1. availability
     2. nama penyewa
     3. durasi
     4. estimasi return good
     */
    
    func update(LentGoods: OwnerGood) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/goods") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "PATCH"
        request.allHTTPHeaderFields = headers
        
        guard let good = LentGoods.goodId else { return }
        
        self.getRecordId(goodId: good) { recordId in
            let rawData: [String:AnyHashable] = [
                "is_available" : true
            ]
            
            let rawField: [String: AnyHashable] = [
                "id" : recordId,
                "fields": rawData
            ]
            
            let rawRecord: [String:AnyHashable] = [
                "records" : [rawField]
            ]
            
            do {
                let body = try JSONSerialization.data(withJSONObject: rawRecord)
                request.httpBody = body
            } catch {
                print(error.localizedDescription)
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {return}
                
                do {
                    let resp = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            task.resume()
        }
        
    }
    
}
