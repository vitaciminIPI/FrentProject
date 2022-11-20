//
//  HistoryViewModels.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 20/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewModels {
    
    let historyUsers = BehaviorRelay<[DataFieldHistory]>(value: [])

    func getAllHistory() {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/rent_history") else {return}
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
//                let resp = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(resp)
                let resp = try JSONDecoder().decode(RecordHistory.self, from: data)
                self.historyUsers.accept(resp.records!)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
}
