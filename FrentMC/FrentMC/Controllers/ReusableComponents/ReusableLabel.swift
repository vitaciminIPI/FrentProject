//
//  ReusableLabel.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 28/09/22.
//

import Foundation
import UIKit

class ReusableLabel: UILabel {
    enum labelTypeEnum {
        case title
        case subtitle
        case labelForm
        case signIn
        case lentStatTitle
        case lentStatBody
        case titleBlack
        case subtitleBlack
        case profileForm
        case errorMessage
    }
    
    public private(set) var labelType: labelTypeEnum
    public private(set) var labelString: String
    
    private func configureLabelStyle() {
        switch labelType {
            case .title:
                self.font = .systemFont(ofSize: 26, weight: .bold)
                self.numberOfLines = 0
                self.textColor = .white
            case .subtitle:
                self.font = .systemFont(ofSize: 20, weight: .semibold)
                self.numberOfLines = 2
                self.textColor = .white
            case .titleBlack:
                self.font = .systemFont(ofSize: 36, weight: .bold)
                self.numberOfLines = 0
                self.textColor = .black
            case .subtitleBlack:
                self.font = .systemFont(ofSize: 20, weight: .semibold)
                self.numberOfLines = 2
                self.textColor = .black
            case .labelForm:
                self.font = .systemFont(ofSize: 20, weight: .bold)
                self.textColor = .black
                self.numberOfLines = 0
            case .signIn:
                self.font = .systemFont(ofSize: 15, weight: .bold)
                self.textColor = .black
                self.numberOfLines = 0
            case .lentStatTitle:
                self.font = .systemFont(ofSize: 20, weight: .semibold)
                self.textColor = .black
            case .lentStatBody:
                self.font = .systemFont(ofSize: 15, weight: .regular)
                self.textColor = .black
                self.numberOfLines = 0
        case .profileForm:
            self.font = .systemFont(ofSize: 15, weight: .semibold)
            self.textColor = .black
            self.numberOfLines = 0
            
        case .errorMessage:
            self.font = .systemFont(ofSize: 20, weight: .bold)
            self.textColor = .red
            self.numberOfLines = 1
        }
        self.textAlignment = .left
    }
    
    init(labelType: labelTypeEnum, labelString: String) {
        self.labelType = labelType
        self.labelString = labelString
        
        super.init(frame: .zero)
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        self.text = labelString
        self.configureLabelStyle()
    }
    
}
