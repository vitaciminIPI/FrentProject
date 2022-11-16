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
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield: )), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy private var emailTF : UITextField = {
        var tf = ReusableTextField(tfType: .email, tfPholder: "Email")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield: )), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy private var passTF : UITextField = {
        var tf =  ReusableTextField(tfType: .password, tfPholder: "Password")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield: )), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy private var ConPassTF : UITextField = {
        var tf =  ReusableTextField(tfType: .password, tfPholder: "Confirm Password")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield: )), for: .editingChanged)
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
    
    lazy private var errorLabel: UILabel = {
        var label = ReusableLabel(labelType: .errorMessage, labelString: "Error Message")
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - VIEW
    lazy private var viewRegister : UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
       return view
    }()
    
    lazy private var indicatorContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isOpaque = false
        return view
    }()
    
    //MARK: - BUTTON
    lazy private var registButton : UIButton = {
        var button = ReusableButton(buttonTypes: .register)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()
    
    lazy private var signInButton: UIButton = {
        var button = ReusableButton(buttonTypes: .signin)
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - STACKVIEW
    lazy private var stackView: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [fNameLabel, fNameTF, emailLabel, emailTF, passLabel, passTF, ConPassLabel, ConPassTF, errorLabel, registButton])
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
    
    //MARK: - ACTIVITY INDICATOR
    lazy private var indicator : UIActivityIndicatorView = {
       let ind = UIActivityIndicatorView()
        ind.style = .large
        ind.color = .white
        return ind
    }()
    
    //MARK: - CONSTANTS
    let registerVM = RegisterViewModel()
    var user: UserModels?
    let apiManager = APICaller()
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        errorLabel.isHidden = true
        indicatorContainer.isHidden = true
        indicator.hidesWhenStopped = true
        
        view.backgroundColor = UIColor().getBgColor()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(viewRegister)
        viewRegister.addSubview(stackView)
        viewRegister.addSubview(hStackView)
        view.addSubview(indicatorContainer)
        indicatorContainer.addSubview(indicator)
        
        //MARK: - INDICATOR ACTIVITY
        indicatorContainer.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        indicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        indicator.centerView(centerX: indicatorContainer.centerXAnchor, centerY: indicatorContainer.centerYAnchor)
//        indicator.startAnimating() -> muncul indicator setelah di start animating
        
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
        
        //MARK: - ERROR MESSAGE
        errorLabel.anchor(top: ConPassTF.bottomAnchor, bottom: nil, leading: self.errorLabel.leadingAnchor, trailing: self.errorLabel.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        
        //MARK: - REGIST BUTTON
        registButton.anchor(top: errorLabel.bottomAnchor, bottom: nil, leading: self.registButton.leadingAnchor, trailing: self.registButton.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        
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
        self.indicatorContainer.isHidden = false
        self.indicator.startAnimating()
        
        guard let userName = self.fNameTF.text else {return}
        guard let userEmail = self.emailTF.text else {return}
        guard let userPassword = self.passTF.text else {return}
        guard let userRepeatPassword = self.ConPassTF.text else {return}
        
        registerVM.registerCompletionHandler { [weak self] (status, message) in
            guard let self = self else {return}
            
            if status {
                self.errorLabel.isHidden = true
                self.user = UserModels(user_id: self.registerVM.getUserId(), name: userName, phone_number: "", email: userEmail, password: self.registerVM.hashFunction(password: userPassword), confirmPassword: self.registerVM.hashFunction(password: userRepeatPassword), nim: "", major: "", entryYear: "", university: "", location: "", student_card: "")
                self.apiManager.save(user: self.user!)
        
                let vc = SuccessRegViewController()
                vc.user = self.user
                
                self.indicator.stopAnimating()
                self.indicatorContainer.isHidden = true
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                self.indicator.stopAnimating()
                self.indicatorContainer.isHidden = true
                self.errorLabel.isHidden = false
                self.errorLabel.text = message
            }
        }
        registerVM.authenticateUserData(name: userName, email: userEmail, password: userPassword, confirmPassword: userRepeatPassword)
    }
    
    @objc func didTapSignIn() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func textFieldDidChange(textfield: UITextField) {
        registButton.isEnabled = !fNameTF.text!.isEmpty && !emailTF.text!.isEmpty && !passTF.text!.isEmpty && !ConPassTF.text!.isEmpty
    }
    
//    struct ViewControllerPreviews: PreviewProvider {
//        static var previews: some View {
//            UIViewControllerPreview {
//                return RegistrationViewController()
//            }
//            .previewDevice("iPhone 13")
//        }
//    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
