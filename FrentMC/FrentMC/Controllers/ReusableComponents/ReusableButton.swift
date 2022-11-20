//
//  ReusableButton.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 29/09/22.
//

import Foundation
import UIKit

class ReusableButton: UIButton {
    
    enum buttonTypeEnum {
        case login
        case next
        case register
        case signin
        case skip
        case isChecked
        case notChecked
        case forgotpass
        case createacc
        case rentProfile
        case lentProfile
        case helpBtn
//        case notif
//        case search
        case contactOwner
        case apple
    }
    
    public private(set) var buttonTypes: buttonTypeEnum
    
    private func configureButtonStyle() {
        switch buttonTypes {
        case .apple:
            self.setTitle("Apple", for: .normal)
            self.backgroundColor = .black
            self.setTitleColor(.white, for: .normal)
        case .login:
            self.setTitle("Login", for: .normal)
            self.backgroundColor = UIColor().getButtonColor()
        case .next:
            self.setTitle("Next", for: .normal)
            self.backgroundColor = UIColor().getButtonColor()
        case .register:
            self.setTitle("Register", for: .normal)
            self.backgroundColor = UIColor().getButtonColor()
        case .signin:
            self.setTitle("Sign In", for: .normal)
            self.backgroundColor = .clear
            self.setTitleColor(UIColor().getButtonColor(), for: .normal)
        case .skip:
            self.setTitle("Skip", for: .normal)
            self.backgroundColor = .white
            self.setTitleColor(UIColor().getButtonColor(), for: .normal)
        case .isChecked:
            let oriImg = UIImage(systemName: "circle.circle.fill")
            let tintedImg = oriImg?.withRenderingMode(.alwaysTemplate)
            self.setImage(tintedImg, for: .normal)
            self.tintColor = UIColor().getButtonColor()
        case .notChecked:
            let oriImg = UIImage(systemName: "circle")
            let tintedImg = oriImg?.withRenderingMode(.alwaysTemplate)
            self.setImage(tintedImg, for: .normal)
            self.tintColor = UIColor().getButtonColor()   
        case .forgotpass:
            self.setTitle("Forgot Password?", for: .normal)
            self.backgroundColor = .clear
            self.setTitleColor(UIColor().getButtonColor(), for: .normal)
        case .createacc:
            self.setTitle("Create Account", for: .normal)
            self.backgroundColor = .clear
            self.setTitleColor(UIColor().getButtonColor(), for: .normal)
            
        case .rentProfile:
            self.setTitle("rent", for: .normal)
            self.backgroundColor = .purple
            self.setTitleColor(UIColor().getButtonColor(), for: .normal)
        case .lentProfile:
            self.setTitle("lent", for: .normal)
            self.backgroundColor = .purple
            self.setTitleColor(UIColor().getButtonColor(), for: .normal)
        case .helpBtn:
            self.setTitle("Save", for: .normal)
            self.backgroundColor = UIColor().getButtonColor()
            self.setTitleColor(.white, for: .normal)
            
        case .contactOwner:
            self.backgroundColor = UIColor().getCustomBlue()
            self.setTitleColor(.white, for: .normal)
        }
        self.layer.cornerRadius = 10
    }
    
    init(buttonTypes: buttonTypeEnum) {
        self.buttonTypes = buttonTypes
        super.init(frame: .zero)
        self.configureButtonStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
