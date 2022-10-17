//
//  LoginViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/9/22.
//

import UIKit
import SwiftUI

final class LoginViewController: UIViewController {
    //MARK: - TEXT FIELD
    lazy private var emailTF : UITextField = {
        var tf = ReusableTextField(tfType: .email, tfPholder: "Email")
        tf.delegate = self
        return tf
    }()
    
    lazy private var passTF : UITextField = {
        var tf =  ReusableTextField(tfType: .password, tfPholder: "Password")
        tf.delegate = self
        return tf
    }()
    
    //MARK: - LABEL
    lazy private var titleLabel : UILabel = {
        var label = ReusableLabel(labelType: .title, labelString: "Rent Everywhere")
        return label
    }()
    
    lazy private var subtitleLabel : UILabel = {
        var label = ReusableLabel(labelType: .subtitle, labelString: "Your one click away study\nequipment rent!")
        return label
    }()
    
    lazy private var emailLabel : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Email*")
        return label
    }()
    
    lazy private var passLabel : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Password*")
        return label
    }()
    
    lazy private var signInLabel: UILabel = {
        var label = ReusableLabel(labelType: .signIn, labelString: "Not Registered yet?")
        return label
    }()
    
    //MARK: - VIEW
    lazy private var viewLogin : UIView = {
        var view = UIView()
        view.backgroundColor = .white
       return view
    }()
    
    //MARK: - BUTTON
    lazy private var forgotPassButton : UIButton = {
        var button = ReusableButton(buttonTypes: .forgotpass)
        button.addTarget(self, action: #selector(didTapForgotPass), for: .touchUpInside)
        return button
    }()
    
    lazy private var createAccButton: UIButton = {
        var button = ReusableButton(buttonTypes: .createacc)
        button.addTarget(self, action: #selector(didTapCreateAcc), for: .touchUpInside)
        return button
    }()
    
    //MARK: - STACKVIEW
    lazy private var stackView: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [emailLabel, emailTF, passLabel, passTF, forgotPassButton])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    
    lazy private var hStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [signInLabel, createAccButton])
        stack.axis = .horizontal
        stack.spacing = 1
        return stack
    }()
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor().getBgColor()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(viewLogin)
        viewLogin.addSubview(stackView)
        viewLogin.addSubview(hStackView)
        
    //MARK: - TITLE
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
    //MARK: - SUBTITLE
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
    //MARK: - VIEW
        viewLogin.anchor(top: subtitleLabel.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
    
        
    //MARK: - EMAIL
        emailLabel.anchor(top: nil, bottom: nil, leading: self.emailLabel.leadingAnchor, trailing: self.emailLabel.trailingAnchor)
        emailTF.anchor(top: emailLabel.bottomAnchor, bottom: nil, leading: self.emailTF.leadingAnchor, trailing: self.emailTF.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    //MARK: - PASSWORD
        passLabel.anchor(top: emailTF.bottomAnchor, bottom: nil, leading: self.passLabel.leadingAnchor, trailing: self.passLabel.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        passTF.anchor(top: passLabel.bottomAnchor, bottom: nil, leading: self.passTF.leadingAnchor, trailing: self.passTF.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    //MARK: - FORGOT PASSWORD
        forgotPassButton.anchor(top: passTF.bottomAnchor, bottom: nil, leading: self.forgotPassButton.leadingAnchor, trailing: self.forgotPassButton.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        
    //MARK: - STACK VIEW
        stackView.anchor(top: viewLogin.topAnchor, bottom: nil, leading: viewLogin.leadingAnchor, trailing: viewLogin.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        stackView.centerView(centerX: self.stackView.centerXAnchor, centerY: self.stackView.centerYAnchor)
        
    //MARK: - SIGN LABEL
        signInLabel.anchor(top: self.signInLabel.topAnchor, bottom: self.signInLabel.bottomAnchor, leading: nil, trailing: nil)
        
    //MARK: - SIGN BUTTON
        createAccButton.anchor(top: self.createAccButton.topAnchor, bottom: self.createAccButton.bottomAnchor, leading: nil, trailing: nil)
        
    //MARK: - HSTACK
        hStackView.anchor(top: stackView.bottomAnchor, bottom: nil, leading: viewLogin.leadingAnchor, trailing: viewLogin.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
        
    }
    
    @objc func didTapForgotPass() {
        print("Upss lupa password ya")
    }
    
    @objc func didTapCreateAcc() {
        print("Bikin akun yuk")
    }
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return LoginViewController()
            }
            .previewDevice("iPhone 13")
        }
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



