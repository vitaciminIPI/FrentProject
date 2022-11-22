//
//  LoginViewModel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 22/11/22.
//

import Foundation

class LoginViewModel {
    let registVM = RegisterViewModel()
    typealias authenticationLoginUser = (_ status: Bool, _ message: String) -> Void
    var loginCallback: authenticationLoginUser?
    
    func validatePassword(password: String) -> Bool {
        if password == "" {
            return false
        }
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
    
    func validateDataLogin(email: String, password: String, isValid: @escaping (Bool)-> Void) {
        let hashPass = registVM.hashFunction(password: password)
        
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user?filterByFormula=%7Bemail%7D=%22\(email)%22&%7Bpassword%7D=%22\(hashPass)%22") else {return}
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer keyiLoxDGSRWhWZ2P"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {return}
            print(email + " " + password)
            do {
                let resp = try JSONDecoder().decode(Record.self, from: data)
                guard let records = resp.records else {return}
                if !records.isEmpty {
                    guard let emailData = records[0].fields?.email else {return}
                    guard let passData = records[0].fields?.password else {return}
                    
                    if (emailData != email) || (passData != hashPass) {
                        print("ga cocok")
                        isValid(false)
                    }
                    else {
                        isValid(true)
                    }
                } else {
                    print("ini kosong")
                    isValid(false)
                }
                
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func getUserData(email: String, password: String, user: @escaping (User)-> Void) {
        let hashPass = registVM.hashFunction(password: password)
        
        guard let url = URL(string: "https://api.airtable.com/v0/app85ELIPoDFHKcGT/user?filterByFormula=%7Bemail%7D=%22\(email)%22&%7Bpassword%7D=%22\(hashPass)%22") else {return}
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
                let resp = try JSONDecoder().decode(Record.self, from: data)
                user((resp.records?[0].fields)!)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func authenticateUserLogin(email: String, password: String) {
        let isValidEmail = registVM.validateEmail(email: email)
        let isValidPassword = validatePassword(password: password)

        let _ = validateDataLogin(email: email, password: password) { isValid in
//            print(email + " " + password)
            if !isValidEmail {
                self.loginCallback?(false, "Invalid Email")
            }
            else if !isValidPassword {
                self.loginCallback?(false, "Invalid Password")
            }
            else if !isValid {
                self.loginCallback?(false, "Invalid email or password")
            }
            else {
                self.loginCallback?(true, "Data Valid")
            }
        }
        
    }
    
    func loginCompletionHandler(callback: @escaping authenticationLoginUser) {
        self.loginCallback = callback
    }
    
}
