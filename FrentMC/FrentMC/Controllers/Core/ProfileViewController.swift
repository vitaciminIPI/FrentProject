//
//  ProfileViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit

class ProfileViewController: UIViewController {

    
    //MARK: -VIEW
    lazy private var viewProfile : UIView = {
        var view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
//    lazy private var viewProfile2 : UIView = {
//        var view = UIView()
//        view.backgroundColor = .purple
//        return view
//    }()

    //MARK: -IMAGE
    lazy private var imgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.circle.fill")
        img.tintColor = .gray
        return img
    }()
    
    //MARK: -TITLE LABEL
    lazy private var titleLabel : UILabel = {
        var label = ReusableLabel(labelType: .title, labelString: "  Username")
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    //MARK: -BUTTON
    lazy private var rentButton : UIButton = {
        var button = ReusableButton(buttonTypes: .rentProfile)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapRentButton), for: .touchUpInside)
        return button
    }()
    
    lazy private var lentButton : UIButton = {
        var button = ReusableButton(buttonTypes: .lentProfile)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapLentButton), for: .touchUpInside)
        return button
    }()
    
    lazy private var helpButton : UIButton = {
        var button = ReusableButton(buttonTypes: .helpBtn)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(didTapHelpButton), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - STACKVIEW
    lazy private var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [imgView, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.distribution = .fillProportionally
        return stack
    }()
    
    
    lazy private var stackView2: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [contactLabel, emailLabel, emailTF, waNumberLabel, waNumberTF, nimLabel, nimTF, preferenceLabel, universityLabel, universityTF, majorLabel, majorTF, locationLabel, locationTF, requestLabel, requestTF ])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    //MARK: - HSTACKVIEW
    lazy private var hStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [rentButton, lentButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    //MARK: - LABEL
    lazy private var contactLabel : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Contact Information")
        return label
    }()
    
    lazy private var emailLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Email*")
        return label
    }()
    
    lazy private var waNumberLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "WhatsApp Number*")
        return label
    }()
    
    lazy private var nimLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "NIM*")
        return label
    }()
    
    lazy private var preferenceLabel : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Preferences")
        return label
    }()
    
    lazy private var universityLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "University*")
        return label
    }()
    
    lazy private var majorLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Major*")
        return label
    }()
    
    lazy private var locationLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Location*")
        return label
    }()
    
    lazy private var requestLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Request Equipment*")
        return label
    }()
    
    //MARK: - TEXTFIELD
    lazy private var emailTF : UITextField = {
        var tf = ReusableTextField(tfType: .email, tfPholder: "Email")
        tf.delegate = self
        return tf
    }()
    
    lazy private var waNumberTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Whatsapp Number")
        tf.delegate = self
        return tf
    }()
    
    lazy private var nimTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Nomer Induk Mahasiswa")
        tf.delegate = self
        return tf
    }()
    
    lazy private var universityTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "university")
        tf.delegate = self
        return tf
    }()
    
    lazy private var majorTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Major")
        tf.delegate = self
        return tf
    }()
    
    lazy private var locationTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "location")
        tf.delegate = self
        return tf
    }()
    
    lazy private var requestTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Request Equipment")
        tf.delegate = self
        return tf
    }()
    
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        view.backgroundColor = .systemBackground
    }
    
    
    //MARK: - setup
    func setupUI(){
        view.addSubview(viewProfile)
        viewProfile.addSubview(stackView)
        view.addSubview(hStackView)
        view.addSubview(stackView2)
        view.addSubview(helpButton)
        
        
        //MARK: - VIEW
        viewProfile.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 60, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 70))
        
        
        //MARK: -IMAGE
        imgView.anchor(top: nil, bottom: nil, leading: self.imgView.leadingAnchor, trailing: self.imgView.trailingAnchor, size: .init(width: 50, height: 0))
        
        //MARK: - STACKVIEW
        stackView.anchor(top: viewProfile.topAnchor, bottom: viewProfile.bottomAnchor, leading: viewProfile.leadingAnchor, trailing: viewProfile.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))

        
        //MARK: - HSTACKVIEW
        hStackView.anchor(top: stackView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
        //MARK: - LABEL
        contactLabel.anchor(top: contactLabel.topAnchor, bottom: contactLabel.bottomAnchor, leading: nil, trailing: nil)
        
        emailLabel.anchor(top: emailLabel.topAnchor, bottom: emailLabel.bottomAnchor, leading: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        waNumberLabel.anchor(top: waNumberLabel.topAnchor, bottom: waNumberLabel.bottomAnchor, leading: nil, trailing: nil)
        
        nimLabel.anchor(top: nimLabel.topAnchor, bottom: nimLabel.bottomAnchor, leading: nil, trailing: nil)
        
        preferenceLabel.anchor(top: preferenceLabel.topAnchor, bottom: preferenceLabel.bottomAnchor, leading: nil, trailing: nil)
        
        universityLabel.anchor(top: universityLabel.topAnchor, bottom: universityLabel.bottomAnchor, leading: nil, trailing: nil)
        
        majorLabel.anchor(top: majorLabel.topAnchor, bottom: majorLabel.bottomAnchor, leading: nil, trailing: nil)
        
        locationLabel.anchor(top: locationLabel.topAnchor, bottom: locationLabel.bottomAnchor, leading: nil, trailing: nil)
        
        requestLabel.anchor(top: requestLabel.topAnchor, bottom: requestLabel.bottomAnchor, leading: nil, trailing: nil)
        
        //MARK: - TEXTFIELD
        emailTF.anchor(top: emailTF.topAnchor, bottom: emailTF.bottomAnchor, leading: nil, trailing: nil)
        
        waNumberTF.anchor(top: waNumberTF.topAnchor, bottom: waNumberTF.bottomAnchor, leading: nil, trailing: nil)
        
        nimTF.anchor(top: nimTF.topAnchor, bottom: nimTF.bottomAnchor, leading: nil, trailing: nil)
        
        universityTF.anchor(top: universityTF.topAnchor, bottom: universityTF.bottomAnchor, leading: nil, trailing: nil)
        
        majorTF.anchor(top: majorTF.topAnchor, bottom: majorTF.bottomAnchor, leading: nil, trailing: nil)
        
        locationTF.anchor(top: locationTF.topAnchor, bottom: locationTF.bottomAnchor, leading: nil, trailing: nil)
        
        requestTF.anchor(top: requestTF.topAnchor, bottom: requestTF.bottomAnchor, leading: nil, trailing: nil)
        
        //MARK: -STACKVIEW2
        
        stackView2.anchor(top: hStackView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: -BUTTON
        helpButton.anchor(top: stackView2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 125, bottom: 0, right: 125), size: .init(width: 50, height: 50))
    }
    
    @objc func didTapRentButton() {
        print("to rent page")
    }
    
    @objc func didTapLentButton() {
        print("to lent page")
    }
    
    
    @objc func didTapHelpButton() {
        print("to help page")
    }
        

}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
