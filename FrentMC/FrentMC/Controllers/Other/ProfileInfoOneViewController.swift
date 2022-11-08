//
//  ProfileInfoOneViewController.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 09/10/22.
//

import UIKit
import SwiftUI

class ProfileInfoOneViewController: UIViewController {
    
    //MARK: - LABEL
    lazy private var titleLabel: UILabel = {
        let label = ReusableLabel(labelType: .title, labelString: "Personal Information")
        return label
    }()
    
    lazy private var subtitleLabel: UILabel = {
        let label = ReusableLabel(labelType: .subtitle, labelString: "Your one click away study equipment rent! Rent everywhere and connect.")
        label.numberOfLines = 3
        return label
    }()
    
    lazy private var waLabel: UILabel = {
        let label = ReusableLabel(labelType: .labelForm, labelString: "WhatsApp Number")
        label.textColor = .white
        return label
    }()
    
    lazy private var bachelorYearEntryLabel: UILabel = {
        let label = ReusableLabel(labelType: .labelForm, labelString: "Bachelor Degree Entry Year")
        label.textColor = .white
        return label
    }()
    
    lazy private var locationLabel: UILabel = {
        let label = ReusableLabel(labelType: .labelForm, labelString: "Location")
        label.textColor = .white
        return label
    }()
    
    //MARK: - TEXTFIELD
    
    lazy private var waTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: +6282112536")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
        return tf
    }()
    
    lazy private var bachelorYearEntryTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: 2019")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
        return tf
    }()
    
    lazy private var locationTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: Jakarta")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
        return tf
    }()
    
    lazy private var errorLabel: UILabel = {
        var label = ReusableLabel(labelType: .errorMessage, labelString: "Error Message")
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - BUTTON
    
    lazy private var backButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .skip)
        btn.setTitle("Back", for: .normal)
        btn.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return btn
    }()
    
    lazy private var nextButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .next)
        btn.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    //MARK: - HSTACK
    lazy private var hStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [backButton, nextButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
       return stack
    }()
    
    //MARK: - CONST N VARIABLES
    let registerVM = RegisterViewModel()
    let apiManager = APICaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupUI()
        //completionhandler
//        apiManager.getUserRecordId(email: "testing@testing.com") { recordId in
//            print(recordId)
//        }
    }
    
    func setupUI() {
        errorLabel.isHidden = true
        view.backgroundColor = UIColor().getBgColor()
        
        //MARK: - TITLE
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
        //MARK: - SUBTITLE
        view.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
        //MARK: - WHATSAPP
        view.addSubview(waLabel)
        view.addSubview(waTF)
        waLabel.anchor(top: subtitleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        waTF.anchor(top: waLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - BACHELOR
        view.addSubview(bachelorYearEntryLabel)
        view.addSubview(bachelorYearEntryTF)
        bachelorYearEntryLabel.anchor(top: waTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        bachelorYearEntryTF.anchor(top: bachelorYearEntryLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        
        //MARK: - LOCATION
        view.addSubview(locationLabel)
        view.addSubview(locationTF)
        locationLabel.anchor(top: bachelorYearEntryTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        locationTF.anchor(top: locationLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - ERROR MESSAGE
        view.addSubview(errorLabel)
        errorLabel.anchor(top: locationTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
        //MARK: - HSTACK
        view.addSubview(hStackView)
        hStackView.anchor(top: errorLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 50, left: 30, bottom: 0, right: 30))
        
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
//        let vc = ProfileInfoTwoViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        guard let userPhone = self.waTF.text else {return}
        guard let userEntryYear = self.bachelorYearEntryTF.text else {return}
        guard let userLocation = self.locationTF.text else {return}
        //        pake .dropfirst buat ngilangin tanda +
        //        print(userPhone.dropFirst())
        registerVM.authenticateUserProfileOne(phoneNumber: userPhone, year: userEntryYear, location: userLocation)
        registerVM.profileOneCompletionHandler { [weak self] (status, message) in
            guard let self = self else {return}
            
            if status {
                self.errorLabel.isHidden = true
                let vc = ProfileInfoTwoViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                self.errorLabel.text = message
                self.errorLabel.isHidden = false
            }
        }
    }
    
    @objc func textFieldDidChange(textfield: UITextField) {
        nextButton.isEnabled = !waTF.text!.isEmpty && !bachelorYearEntryTF.text!.isEmpty && !locationTF.text!.isEmpty
    }
    
//    struct ViewControllerPreviews: PreviewProvider {
//        static var previews: some View {
//            UIViewControllerPreview {
//                return ProfileInfoOneViewController()
//            }
//            .previewDevice("iPhone 13")
//        }
//    }

}

extension ProfileInfoOneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
