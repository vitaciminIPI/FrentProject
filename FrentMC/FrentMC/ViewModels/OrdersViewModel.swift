//
//  OrdersViewModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 17/11/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class OrdersViewModel {
    
    let orders = BehaviorRelay<[DataFieldOrders]>(value: [])
    
    func getAllOrders() {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/rent_orders") else {return}
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
                let resp = try JSONDecoder().decode(RecordOrders.self, from: data)
                print(resp)
                self.orders.accept(resp.records!)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
}
