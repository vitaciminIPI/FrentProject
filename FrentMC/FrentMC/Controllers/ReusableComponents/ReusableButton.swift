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
    }
    
    public private(set) var buttonTypes: buttonTypeEnum
    
    private func configureButtonStyle() {
        switch buttonTypes {
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
