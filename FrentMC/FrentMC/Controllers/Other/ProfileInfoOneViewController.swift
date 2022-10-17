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
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: 6282112536")
        return tf
    }()
    
    lazy private var bachelorYearEntryTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: 2019")
        return tf
    }()
    
    lazy private var locationTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: Jakarta")
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
        
        //MARK: - HSTACK
        view.addSubview(hStackView)
        hStackView.anchor(top: locationTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 30, bottom: 0, right: 30))
        
    }
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return ProfileInfoOneViewController()
            }
            .previewDevice("iPhone 13")
        }
    }

}
