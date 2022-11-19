//
//  APICaller.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import Foundation
import UIKit

class APICaller {
    func save (user: UserModels, completion: @escaping (String)-> Void) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user") else {return}
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
                let resp = try JSONDecoder().decode(Record.self, from: data)
                completion(resp.records?[0].id ?? "")
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
    
    func uploadImage(image: UIImage, completion: @escaping (String)-> Void) {
        let vm = RegisterViewModel()
        let key = "7ac071ab9d32e916bf8a13c32dc35ac5"
        let fullUrl = "https://api.imgbb.com/1/upload?key=\(key)"
        guard let url = URL(string: fullUrl) else {return}
        
        vm.getBase64(image: image) { base64 in
            let boundary = "Boundary-\(UUID().uuidString)"
            var request = URLRequest(url: url)

            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            var body = ""
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"image\""
            body += "\r\n\r\n\(base64 ?? "")\r\n"
            body += "--\(boundary)--\r\n"
            let postData = body.data(using: .utf8)

            request.httpBody = postData
            
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 30
            config.timeoutIntervalForResource = 60
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, _, err) in
                guard let data = data, err == nil else {
                    print("error")
                    return
                }

                var parsingResp: DataImage?

                do {
                    let resp = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(resp)
                    parsingResp = try JSONDecoder().decode(DataImage.self, from: data)
                } catch {
                    print(error)
                }

                guard let result = parsingResp else {return}
                let urlImage = result.data.image.url
                completion(urlImage)

            }
            task.resume()
        }

    }
    
    func updateUser(user: UserModels, image: UIImage) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user") else {return}
        let userEmail = user.email
        let phoneNumber = user.phone_number
        let entryYear = user.entryYear
        let location = user.location
        let userNim = user.nim
        let userMajor = user.major
        let userUniv = user.university
        var request = URLRequest(url: url)
        let headers = [
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P",
            "Content-Type" : "application/json"
        ]

       request.httpMethod = "PATCH"
       request.allHTTPHeaderFields = headers
        
        print("Updating user")
        
        self.uploadImage (image: image) { url in
            print("url : \(url)")
            let imagesData : [String: AnyHashable] = [
                "url" : url
            ]
            
            self.getUserRecordId(email: userEmail) { recordId in
                let userFields : [String: AnyHashable] = [
                    "phone_number" : phoneNumber,
                    "entry_year" : entryYear,
                    "location" : location,
                    "nim" : userNim,
                    "major" : userMajor,
                    "university" : userUniv,
                    "student_card" : [imagesData]
                ]
                
                
                let dataFields: [String : AnyHashable] = [
                    "id" : recordId,
                    "fields" : userFields
                ]
                let recordsData : [String : AnyHashable] = [
                    "records" : [dataFields]
                ]
                
                print("records id : \(recordId)")
                
                do {
                    let requestBody = try JSONSerialization.data(withJSONObject: recordsData)
                    request.httpBody = requestBody
                } catch {
                    print("error")
                }
                
                let task = URLSession.shared.dataTask(with: request) { (data, _, err) in
                    guard let data = data, err == nil else {
                        print("data nil")
                        return
                    }
                    
                    do {
                        let resp = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        print(resp)
                    } catch {
                        print("error parsing")
                    }
                }
                
                task.resume()
            }
        }
    }
    
    func createLink(number: String, good: String) -> String {
        let textTemplate = "Halo%20saya%20ingin%20meminjam%20barang%20\(good)"
        let whatsAppURL = "https://wa.me/\(number)?text=\(textTemplate)"
        
        return whatsAppURL
    }
    
    func createOwner(roleId: String) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/owner") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let ownerdata: [String : AnyHashable] = [
            "role_id" : [roleId]
        ]
        
        let datafields: [String : AnyHashable] = [
            "fields" : ownerdata
        ]
        
        let records: [String : AnyHashable] = [
            "records" : [datafields]
        ]
        
        do {
            let body = try JSONSerialization.data(withJSONObject: records, options: .fragmentsAllowed)
            request.httpBody = body
        } catch {
            print("error parsing")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                print("somethings wrong")
                return
            }
            
            do {
                let resp = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(resp)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
    func createRole(user: UserModels, completion: @escaping (String)-> Void) {
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/role") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let roledata: [String : AnyHashable] = [
            "name" : "Owner",
            "user_id" : [user.user_id]
        ]
        
        let datafields: [String : AnyHashable] = [
            "fields" : roledata
        ]
        
        let records: [String : AnyHashable] = [
            "records": [datafields]
        ]
        
        do {
            let body = try JSONSerialization.data(withJSONObject: records, options: .fragmentsAllowed)
            request.httpBody = body
        } catch {
            print("error parsing")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                print("somethings wrong")
                return
            }
            
            do {
                let resp = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(resp)
                let response = try JSONDecoder().decode(RecordRole.self, from: data)
                completion(response.records?[0].id ?? "")
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
}
