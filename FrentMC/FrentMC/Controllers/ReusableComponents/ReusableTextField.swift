//
//  ReusableTextField.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 28/09/22.
//

import Foundation
import UIKit

class ReusableTextField: UITextField {
 
    enum tfTypeEnum {
        case email
        case password
        case defaults
    }
    
    public private(set) var tfType: tfTypeEnum
    public private(set) var tfPHolder: String
    
    private func configureTFStyle() {
        switch tfType {
        case .email:
            self.keyboardType = .emailAddress
        case .password:
            self.isSecureTextEntry = true
        case .defaults:
            self.keyboardType = .alphabet
        }
        
        self.font = .systemFont(ofSize: 16)
    }
    
    init(tfType: tfTypeEnum, tfPholder: String) {
        self.tfType = tfType
        self.tfPHolder = tfPholder

        super.init(frame: .zero)
        self.configureTF()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTF() {
        self.placeholder = tfPHolder
        self.configureTFStyle()
    }
    
}
