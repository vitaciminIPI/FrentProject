//
//  RequestGoodsViewModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 18/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class RequestGoodsViewModel {
    let reqGoods = BehaviorRelay<[DataFieldRGood]>(value: [])
    
    func fetchRequestedGoods() {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, err) in
            guard let data = data, err == nil else {
                print("there is error")
                return
            }
            
            do {
                let resp = try JSONDecoder().decode(RecordRGood.self, from: data)
                self.reqGoods.accept((resp.records!))
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
