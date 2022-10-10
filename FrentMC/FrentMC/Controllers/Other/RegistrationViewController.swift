//
//  RegistrationViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit
import SwiftUI

final class RegistrationViewController: UIViewController {
    //MARK: - TEXT FIELD
    lazy private var fNameTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Full Name")
        tf.delegate = self
        return tf
    }()
    
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
    
    lazy private var ConPassTF : UITextField = {
        var tf =  ReusableTextField(tfType: .password, tfPholder: "Confirm Password")
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
    
    lazy private var fNameLabel : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Full Name*")
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
    
    lazy private var ConPassLabel : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Confirm Password*")
        return label
    }()
    
    lazy private var signInLabel: UILabel = {
        var label = ReusableLabel(labelType: .signIn, labelString: "Already have an account?")
        return label
    }()
    
    //MARK: - VIEW
    lazy private var viewRegister : UIView = {
        var view = UIView()
        view.backgroundColor = .white
       return view
    }()
    
    //MARK: - BUTTON
    lazy private var registButton : UIButton = {
        var button = ReusableButton(buttonTypes: .register)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    lazy private var signInButton: UIButton = {
        var button = ReusableButton(buttonTypes: .signin)
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - STACKVIEW
    lazy private var stackView: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [fNameLabel, fNameTF, emailLabel, emailTF, passLabel, passTF, ConPassLabel, ConPassTF, registButton])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    
    lazy private var hStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [signInLabel, signInButton])
        stack.axis = .horizontal
        stack.spacing = 1
        return stack
    }()
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor().getBgColor()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(viewRegister)
        viewRegister.addSubview(stackView)
        viewRegister.addSubview(hStackView)
        
        //MARK: - TITLE
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
        //MARK: - SUBTITLE
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
        //MARK: - VIEW
        viewRegister.anchor(top: subtitleLabel.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
        
        //MARK: - FULL NAME
        fNameLabel.anchor(top: nil, bottom: nil, leading: self.fNameLabel.leadingAnchor, trailing: self.fNameLabel.trailingAnchor)
        fNameTF.anchor(top: fNameLabel.bottomAnchor, bottom: nil, leading: self.fNameTF.leadingAnchor, trailing: self.fNameTF.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        //MARK: - EMAIL
        emailLabel.anchor(top: fNameTF.bottomAnchor, bottom: nil, leading: self.emailLabel.leadingAnchor, trailing: self.emailLabel.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        emailTF.anchor(top: emailLabel.bottomAnchor, bottom: nil, leading: self.emailTF.leadingAnchor, trailing: self.emailTF.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        //MARK: - PASSWORD
        passLabel.anchor(top: emailTF.bottomAnchor, bottom: nil, leading: self.passLabel.leadingAnchor, trailing: self.passLabel.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        passTF.anchor(top: passLabel.bottomAnchor, bottom: nil, leading: self.passTF.leadingAnchor, trailing: self.passTF.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        //MARK: - CONFIRM PASSWORD
        ConPassLabel.anchor(top: passTF.bottomAnchor, bottom: nil, leading: self.ConPassLabel.leadingAnchor, trailing: self.ConPassLabel.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        ConPassTF.anchor(top: ConPassLabel.bottomAnchor, bottom: nil, leading: self.ConPassTF.leadingAnchor, trailing: self.ConPassTF.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        //MARK: - REGIST BUTTON
        registButton.anchor(top: ConPassTF.bottomAnchor, bottom: nil, leading: self.registButton.leadingAnchor, trailing: self.registButton.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        
        //MARK: - STACK VIEW
        stackView.anchor(top: viewRegister.topAnchor, bottom: nil, leading: viewRegister.leadingAnchor, trailing: viewRegister.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        stackView.centerView(centerX: self.stackView.centerXAnchor, centerY: self.stackView.centerYAnchor)
        
        //MARK: - SIGN LABEL
        signInLabel.anchor(top: self.signInLabel.topAnchor, bottom: self.signInLabel.bottomAnchor, leading: nil, trailing: nil)
        
        //MARK: - SIGN BUTTON
        signInButton.anchor(top: self.signInButton.topAnchor, bottom: self.signInButton.bottomAnchor, leading: nil, trailing: nil)
        
        //MARK: - HSTACK
        hStackView.anchor(top: stackView.bottomAnchor, bottom: nil, leading: viewRegister.leadingAnchor, trailing: viewRegister.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
    }
    
    @objc func didTapRegister() {
        print("register")
    }
    
    @objc func didTapSignIn() {
        print("sign in")
    }
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return RegistrationViewController()
            }
            .previewDevice("iPhone 13")
        }
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
