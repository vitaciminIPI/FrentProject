//
//  LoginWithAppleIDViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/9/22.
//

import UIKit
import SwiftUI
import AuthenticationServices

class LoginWithAppleIDViewController: UIViewController {

    
    
    // MARK: - IMAGE & LABEL
    lazy private var imgView: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "FrentLogin")
            return img
    }()
    
    lazy private var titles: UILabel = {
            let label = ReusableLabel(labelType: .titleBlack, labelString: "FRent!")
            label.font = .systemFont(ofSize: 40, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
            return label
    }()
        
    lazy private var subtitles: UILabel = {
            let label = ReusableLabel(labelType: .subtitleBlack, labelString: "Sewa buku dan alat kuliah \ndari teman di kampusmu!")
            label.font = .systemFont(ofSize: 18, weight: .regular)
            label.numberOfLines = 2
            label.textAlignment = .center
            return label
    }()
    
    lazy private var or: UILabel = {
            let label = ReusableLabel(labelType: .subtitleBlack, labelString: "OR")
            label.font = .systemFont(ofSize: 12, weight: .semibold)
            label.numberOfLines = 1
            label.textAlignment = .center
            return label
    }()
    
    lazy private var bottomLabel: UILabel = {
            let label = ReusableLabel(labelType: .subtitleBlack, labelString: "By Continuing You Agree to the\n Terms and Conditions")
            label.font = .systemFont(ofSize: 15, weight: .semibold)
            label.numberOfLines = 2
            label.textAlignment = .center
            return label
    }()
    
    // MARK: - BUTTON
    lazy private var loginButton: UIButton = {
            var btn = ReusableButton(buttonTypes: .next)
            btn.setTitle("I'm an Existing User", for: .normal)
            btn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
            return btn
    }()
        
    lazy private var registButton: UIButton = {
            var btn = ReusableButton(buttonTypes: .next)
            btn.setTitle("Create an Account", for: .normal)
            btn.addTarget(self, action: #selector(registBtnTapped), for: .touchUpInside)
            return btn
    }()
    
//    lazy private var appleButton: UIButton = {
//            var btn = ReusableButton(buttonTypes: .next)
//            btn.setTitle("Sign With Apple", for: .normal)
//            btn.addTarget(self, action: #selector(appleBtnTapped), for: .touchUpInside)
//            return btn
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupApple()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipButtonTapped))
    }
    
    func setupApple(){
        //MARK: - button apple id
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.overrideUserInterfaceStyle = .light
        appleButton.addTarget(self, action: #selector(TappedSignInApple), for: .touchUpInside)
        
        view.addSubview(appleButton)
        appleButton.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .zero, size: .init(width: 290, height: 50))
        appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 265).isActive = true
        appleButton.cornerRadius = 10
        appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupUI(){
        
        
        view.backgroundColor = .white
        //MARK: - IMAGEVIEW
        view.addSubview(imgView)
        imgView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .zero, size: .init(width: 150, height: 150))
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //MARK: - TITLES
        view.addSubview(titles)
        titles.anchor(top: imgView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 50, bottom: 0, right: 50))
        
        //MARK: - SUBTITLES
        view.addSubview(subtitles)
        subtitles.anchor(top: titles.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 50, bottom: 50, right: 50))
        
        //MARK: - COMPLETE REG BUTTON
        view.addSubview(loginButton)
        loginButton.anchor(top: subtitles.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 50, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
                
        //MARK: - SKIP BUTTON
        view.addSubview(registButton)
        registButton.anchor(top: loginButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
        
        //MARK: - OR
        view.addSubview(or)
        or.anchor(top: registButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 50, bottom: 50, right: 50))
        
        //MARK: - APPLEBUTTON
//        view.addSubview(appleButton)
//        appleButton.anchor(top: or.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 50, bottom: 50, right: 50), size: .init(width: 0, height: 50))
        
        
        //MARK: - BOTTOMLABEL
//        view.addSubview(bottomLabel)
//        bottomLabel.anchor(top: appleButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 50, bottom: 50, right: 50))

    }
    
    @objc func loginBtnTapped(){
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func registBtnTapped(){
        self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    @objc func appleBtnTapped(){
        self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    @objc func skipButtonTapped(){
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
    }

    @objc func TappedSignInApple(){
        print("sign in tapped")
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}

extension LoginWithAppleIDViewController:ASAuthorizationControllerDelegate{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print("Error",error)
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            print(credentials)
            print(credentials.user)
            print(credentials.fullName?.givenName)
            print(credentials.fullName?.familyName)
            print(credentials.email)
            print("Login Sucess")
            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            
            
        case let credentials as ASPasswordCredential :
            print(credentials.password)
            
            
//            let userIdentifier = credentials.user
//            let fullName = credentials.fullName
//            let email = credentials.email
//            let firstName = credentials.fullName?.givenName
//            let lastName = credentials.fullName?.familyName
            
//            print(userIdentifier)
//            print(fullName ?? "0")
//            print(email ?? "0")
//            print(firstName ?? "0")
//            print(lastName ?? "0")
            
//            self.saveUserInKeychain(userIdentifier)
//
//            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
//
//        case let passwordCredential as ASPasswordCredential:
//
//            let username = passwordCredential.user
//            let password = passwordCredential.password
//
//            DispatchQueue.main.async {
//                self.showPasswordCredentialAlert(username: username, password: password)
//            }
            
//            let user = User(credentials: credentials)
//            self.signUpSocial(emailAddress: user.email, firstName: user.firstName, lastName: user.lastName, socialID: user.id, socialName: "Apple")
//            break
            
        default:
            let alert = UIAlertController(title: "Apple SignIn", message: "Something went wrong with your Apple SignIn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
    }
}

var window: UIWindow?

extension LoginWithAppleIDViewController:ASAuthorizationControllerPresentationContextProviding{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
//        let viewController = TabBarViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
//
//        return window?.rootViewController = navigationController
//
//        self.window = Window
//        window?.makeKeyAndVisible()
        return view.window!
     }
}

