//
//  APICaller.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import Foundation

class APICaller {
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
    
    func getUserRecordId(email: String, completion: @escaping (_ recordId: String) -> Void) {
        let urlString = "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user?filterByFormula=%7Bemail%7D=%22\(email)%22"
        guard let url = URL(string: urlString) else {
            print("Url Error")
            return
        }
        
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Error when getting data")
                return
            }
            
            var resultDecode: Record?
            let decoder = JSONDecoder()
            do {
                resultDecode = try decoder.decode(Record.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            
            guard let json = resultDecode else {return}
            
//            print(json.records?[0].id ?? "Data nil")
            let recordString = json.records?[0].id ?? "Data nil"
//            print(recordString)
            completion(recordString)
        }
        
        task.resume()
    }
    
    func update (user: UserModels) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user") else {return}
        
        let userEmail = user.email
        let phoneNumber = user.phone_number
        let entryYear = user.entryYear
        let location = user.location
        let userNim = user.nim
        let userImage = user.student_card

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"

        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        request.allHTTPHeaderFields = headers
        
        getUserRecordId(email: userEmail) { recordId in
            let userFields: [String : AnyHashable] = [
                "phone_number": phoneNumber,
                "entry_year": entryYear,
                "location": location,
                "nim": userNim,
                "student_card": userImage
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
