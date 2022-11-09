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
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 3.0)
//        view.layer.shadowRadius = 2.0
//        view.layer.shadowOpacity = 1.0
//        view.layer.masksToBounds = false
//        view.layer.backgroundColor = UIColor.clear.cgColor
        return view
    }()

    //MARK: -IMAGE
    lazy private var imgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.circle.fill")
        img.tintColor = .gray
        return img
    }()
    
    //MARK: -TITLE LABEL
    lazy private var titleLabel : UILabel = {
        var label = ReusableLabel(labelType: .titleBlack, labelString: "  FRent!")
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy private var titleVersion : UILabel = {
        var label = ReusableLabel(labelType: .titleBlack, labelString: "V. 1.1.0")
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    //MARK: -BUTTON
    lazy private var pencilEditButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(pencilEditButtonTapped), for: .touchUpInside)
        let img = UIImage(systemName: "square.and.arrow.down.fill")
        let tintedImg = img?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintedImg, for: .normal)
        btn.tintColor = UIColor().getButtonColor()
        return btn
    }()
    
    lazy private var rentButton : UIButton = {
        var button = ReusableButton(buttonTypes: .rentProfile)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapRentButton), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(genericCMYKCyan: 0, magenta: 255, yellow: 255, black: 255, alpha: 1)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
        return button
    }()
    
    lazy private var lentButton : UIButton = {
        var button = ReusableButton(buttonTypes: .lentProfile)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapLentButton), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(genericCMYKCyan: 0, magenta: 255, yellow: 255, black: 255, alpha: 1)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
        return button
    }()
    
    lazy private var helpButton : UIButton = {
        var button = ReusableButton(buttonTypes: .helpBtn)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapHelpButton), for: .touchUpInside)
        return button
    }()
    
    lazy private var errorLabel: UILabel = {
        var label = ReusableLabel(labelType: .errorMessage, labelString: "Error Message")
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - STACKVIEW
    lazy private var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [imgView, titleLabel, pencilEditButton])
        stack.axis = .horizontal
        stack.spacing = 3
        stack.distribution = .fillProportionally
        return stack
    }()
    
    
    lazy private var stackView2: UIStackView = {
//        var stack = UIStackView(arrangedSubviews: [contactLabel, emailLabel, emailTF, waNumberLabel, waNumberTF, nimLabel, nimTF, preferenceLabel, universityLabel, universityTF, majorLabel, majorTF, locationLabel, locationTF, requestLabel, requestTF ])
        
        var stack = UIStackView(arrangedSubviews: [contactLabel, emailLabel, emailTF, waNumberLabel, waNumberTF, nimLabel, nimTF, preferenceLabel, universityLabel, universityTF, locationLabel, locationTF, requestLabel, requestTF ])
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
        var label = ReusableLabel(labelType: .labelForm, labelString: "Informasi Personal")
        return label
    }()
    
    lazy private var emailLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Email")
        return label
    }()
    
    lazy private var waNumberLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "WhatsApp")
        return label
    }()
    
    lazy private var nimLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "NIM")
        return label
    }()
    
    lazy private var preferenceLabel : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Domisili & Wishlist")
        return label
    }()
    
    lazy private var universityLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Universitas")
        return label
    }()
    
//    lazy private var majorLabel : UILabel = {
//        var label = ReusableLabel(labelType: .profileForm, labelString: "Major*")
//        return label
//    }()
    
    lazy private var locationLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Lokasi")
        return label
    }()
    
    lazy private var requestLabel : UILabel = {
        var label = ReusableLabel(labelType: .profileForm, labelString: "Barang Permintaan")
        return label
    }()
    
    //MARK: - TEXTFIELD
    lazy private var emailTF : UITextField = {
        var tf = ReusableTextField(tfType: .email, tfPholder: "Email@email.com")
        tf.delegate = self
        return tf
    }()
    
    lazy private var waNumberTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "08xx-xxxx-xxxx")
        tf.delegate = self
        return tf
    }()
    
    lazy private var nimTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "23xx-xxxx-xxxx")
        tf.delegate = self
        return tf
    }()
    
    lazy private var universityTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "universitas xxxxx")
        tf.delegate = self
        return tf
    }()
    
    lazy private var locationTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Jakarta")
        tf.delegate = self
        return tf
    }()
    
    lazy private var requestTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Penggaris Gamtek, Buku Teknik, Tempat Makan")
        tf.delegate = self
        return tf
    }()
    
    //MARK: - CONSTANS
    let profileVM = ProfileViewModel()
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        setupUI()
        view.backgroundColor = .white
    }
    
    
    //MARK: - setup
    func setupUI(){
        view.addSubview(viewProfile)
        viewProfile.addSubview(stackView)
        view.addSubview(hStackView)
        view.addSubview(stackView2)
        view.addSubview(helpButton)
        view.addSubview(titleVersion)
        view.addSubview(errorLabel)
        
        
        
        //MARK: - VIEW
        viewProfile.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 60, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 70))
        
        
        //MARK: -IMAGE
        imgView.anchor(top: nil, bottom: nil, leading: self.imgView.leadingAnchor, trailing: self.imgView.trailingAnchor, size: .init(width: 50, height: 0))
        
        pencilEditButton.anchor(top: nil, bottom: nil, leading: self.pencilEditButton.leadingAnchor, trailing: self.pencilEditButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 30), size: .init(width: 25, height: 25))
        
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
        
        locationLabel.anchor(top: locationLabel.topAnchor, bottom: locationLabel.bottomAnchor, leading: nil, trailing: nil)
        
        requestLabel.anchor(top: requestLabel.topAnchor, bottom: requestLabel.bottomAnchor, leading: nil, trailing: nil)
        
        //MARK: - TEXTFIELD
        emailTF.anchor(top: emailTF.topAnchor, bottom: emailTF.bottomAnchor, leading: nil, trailing: nil)
        
        waNumberTF.anchor(top: waNumberTF.topAnchor, bottom: waNumberTF.bottomAnchor, leading: nil, trailing: nil)
        
        nimTF.anchor(top: nimTF.topAnchor, bottom: nimTF.bottomAnchor, leading: nil, trailing: nil)
        
        universityTF.anchor(top: universityTF.topAnchor, bottom: universityTF.bottomAnchor, leading: nil, trailing: nil)
        
        locationTF.anchor(top: locationTF.topAnchor, bottom: locationTF.bottomAnchor, leading: nil, trailing: nil)
        
        requestTF.anchor(top: requestTF.topAnchor, bottom: requestTF.bottomAnchor, leading: nil, trailing: nil)
        
        //MARK: -STACKVIEW2
        
        stackView2.anchor(top: hStackView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: -BUTTON
        helpButton.anchor(top: stackView2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 125, bottom: 0, right: 125), size: .init(width: 60, height: 40))
        
        //MARK: LABEL
        titleVersion.anchor(top: helpButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 175, bottom: 0, right: 0))
        
        errorLabel.anchor(top: titleVersion.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 10))
    }
    
    //MARK: -BUTTON FUNCTION
    @objc func didTapRentButton() {
        self.navigationController?.pushViewController(RentStatusViewController(), animated: true)
    }
    
    @objc func didTapLentButton() {
        print("to lent page")
        self.navigationController?.pushViewController(LentStatusViewController(), animated: true)
    }
    
    @objc func pencilEditButtonTapped() {
        print("data has been save")
        //        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    

    @objc func didTapHelpButton() {
        print("Bantuan Segera ya...")
        guard let userEmail = self.emailTF.text else {return}
        guard let phone_number = self.waNumberTF.text else {return}
        guard let nim = self.nimTF.text else {return}
        guard let university = self.universityTF.text else {return}
        guard let location = self.locationTF.text else {return}
        guard let request_goods = self.requestTF.text else {return}
        
        print(userEmail)
        print(phone_number)
        print(nim)
        print(university)
        print(location)
        print(request_goods)
        
        profileVM.authenticateUserProfile(email: userEmail, phoneNumber: phone_number, nimNumber: nim, university: university, location: location, request_goods: request_goods)
        
        profileVM.profileCompletionHandler {[weak self] (status, message) in guard let self = self else {return}
            if status {
                self.errorLabel.isHidden = true
                self.navigationController?.popViewController(animated: true)
            }
            else{
                self.errorLabel.isHidden = false
                self.errorLabel.text = message
            }
        }
        
    
    }
    
}

    //MARK: - EXTENSION
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

