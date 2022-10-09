//
//  SuccessRegViewController.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 06/10/22.
//

import UIKit
import SwiftUI

class SuccessRegViewController: UIViewController {

    lazy private var imgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "diamond_app_icon")
        img.layer.masksToBounds = false
        img.layer.cornerRadius = 75
        img.clipsToBounds = true
        return img
    }()
    
    lazy private var titles: UILabel = {
        let label = ReusableLabel(labelType: .title, labelString: "Your registration is successful!")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy private var subtitles: UILabel = {
        let label = ReusableLabel(labelType: .subtitle, labelString: "Start renting and lending now by completing your account registration!")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    lazy private var completeRegButton: UIButton = {
        var btn = ReusableButton(buttonTypes: .next)
        btn.setTitle("Complete my account", for: .normal)
        btn.addTarget(self, action: #selector(completeBtnTapped), for: .touchUpInside)
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    lazy private var skipButton: UIButton = {
        var btn = ReusableButton(buttonTypes: .signin)
        btn.setTitle("Skip for later", for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(skipForLaterTapped), for: .touchUpInside)
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor().getBgColor()
        
        //MARK: - IMAGEVIEW
        view.addSubview(imgView)
        imgView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .zero, size: .init(width: 150, height: 150))
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //MARK: - TITLES
        view.addSubview(titles)
        titles.anchor(top: imgView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 50, bottom: 0, right: 50))
        
        //MARK: - SUBTITLES
        view.addSubview(subtitles)
        subtitles.anchor(top: titles.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 50, bottom: 50, right: 50))
        
        //MARK: - COMPLETE REG BUTTON
        view.addSubview(completeRegButton)
        completeRegButton.anchor(top: subtitles.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
        
        //MARK: - SKIP BUTTON
        view.addSubview(skipButton)
        skipButton.anchor(top: completeRegButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
    }
    
    @objc func completeBtnTapped() {
        print("Complete registration")
    }
    
    @objc func skipForLaterTapped() {
        print("Skip Fill Profile")
    }
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return SuccessRegViewController()
            }
            .previewDevice("iPhone 13")
        }
    }
}
