//
//  ProfileInfoTwoViewController.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 10/10/22.
//

import UIKit
import SwiftUI

class ProfileInfoTwoViewController: UIViewController {
    
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
    
    lazy private var univNameLabel: UILabel = {
        let label = ReusableLabel(labelType: .labelForm, labelString: "University Name")
        label.textColor = .white
        return label
    }()
    
    lazy private var majorLabel: UILabel = {
        let label = ReusableLabel(labelType: .labelForm, labelString: "Major")
        label.textColor = .white
        return label
    }()
    
    lazy private var studentIdLabel: UILabel = {
        let label = ReusableLabel(labelType: .labelForm, labelString: "Student ID")
        label.textColor = .white
        return label
    }()
    
    //MARK: - TEXTFIELD
    lazy private var univNameTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: BINUS, UI, ITB, etc")
        return tf
    }()
    
    lazy private var majorTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: IT, SI, LAW, etc")
        return tf
    }()
    
    lazy private var studentIdTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: 1902372642")
        tf.keyboardType = .numberPad
        return tf
    }()
    
    
    //MARK: - BUTTON
    lazy private var backButton: UIButton = {
            let btn = ReusableButton(buttonTypes: .skip)
            btn.setTitle("Back", for: .normal)
            return btn
        }()
        
    lazy private var nextButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .next)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor().getBgColor()
        
        //MARK: - TITLE
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
               
       //MARK: - SUBTITLE
       view.addSubview(subtitleLabel)
       subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
       
        //MARK: - UNIVNAME
        view.addSubview(univNameLabel)
        univNameLabel.anchor(top: subtitleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        
        view.addSubview(univNameTF)
        univNameTF.anchor(top: univNameLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - MAJOR
        view.addSubview(majorLabel)
        majorLabel.anchor(top: univNameTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        
        view.addSubview(majorTF)
        majorTF.anchor(top: majorLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - STUDENT ID
        view.addSubview(studentIdLabel)
        studentIdLabel.anchor(top: majorTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        
        view.addSubview(studentIdTF)
        studentIdTF.anchor(top: studentIdLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
    }
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return ProfileInfoTwoViewController()
            }
            .previewDevice("iPhone 13")
        }
    }
}
