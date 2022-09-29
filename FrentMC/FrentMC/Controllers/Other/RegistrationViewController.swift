//
//  RegistrationViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit
import SwiftUI

final class RegistrationViewController: UIViewController {

    lazy private var fNameTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Email")
        return tf
    }()
    
    lazy private var emailTF : UITextField = {
        var tf = ReusableTextField(tfType: .email, tfPholder: "Email")
        return tf
    }()
    
    lazy private var passTF : UITextField = {
        var tf =  ReusableTextField(tfType: .password, tfPholder: "")
        return tf
    }()
    
    lazy private var ConPassTF : UITextField = {
        var tf =  ReusableTextField(tfType: .password, tfPholder: "")
        return tf
    }()
    
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
    
    lazy private var viewRegister : UIView = {
        var view = UIView()
        view.backgroundColor = .white
       return view
    }()
    
    lazy private var registButton : UIButton = {
        var button = ReusableButton(buttonTypes: .register)
        return button
    }()
    
    lazy private var stackView: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [fNameLabel, fNameTF, emailLabel, emailTF, passLabel, passTF, ConPassLabel, ConPassTF])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 20
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor().getBgColor()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(viewRegister)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        
        viewRegister.anchor(top: subtitleLabel.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
        
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
