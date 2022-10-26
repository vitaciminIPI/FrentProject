//
//  AlertService.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/24/22.
//

import UIKit

class AlertService {
    
    static func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions {
            alert.addAction(action)
        }
        
//        if let topVC = UIApplication.getTopMostViewController()
//            alert.UIPopoverPresentationController?.source
        
    }
}
