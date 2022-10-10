//
//  ProfileInfoTwoViewController.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 10/10/22.
//

import UIKit
import SwiftUI
import Photos
import PhotosUI

class ProfileInfoTwoViewController: UIViewController {
    
    //MARK: - LABEL
    lazy private var titleLabel: UILabel = {
       let label = ReusableLabel(labelType: .title, labelString: "Personal Information")
        label.font = .systemFont(ofSize: 20)
       return label
   }()
       
   lazy private var subtitleLabel: UILabel = {
       let label = ReusableLabel(labelType: .subtitle, labelString: "Your one click away study equipment rent! Rent everywhere and connect.")
       label.numberOfLines = 3
       label.font = .systemFont(ofSize: 16)
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
    
    lazy private var studentIdImageLabel: UILabel = {
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
    
    lazy private var uploadButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .next)
        btn.setTitle("Upload Student ID (PNG/JPG)", for: .normal)
        btn.addTarget(self, action: #selector(didUploadImageTapped), for: .touchUpInside)
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

    //MARK: - IMAGEVIEW
    lazy private var imageView: UIImageView = {
       let img = UIImageView()
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor().getBgColor()
        
        //MARK: - TITLE
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
               
       //MARK: - SUBTITLE
       view.addSubview(subtitleLabel)
       subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
       
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
        
        //MARK: - STUDENT ID IMAGE LABEL
        view.addSubview(studentIdImageLabel)
        studentIdImageLabel.anchor(top: studentIdTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
        //MARK: - STUDENT ID IMAGE
//        view.addSubview(imageView)
//        imageView.anchor(top: studentIdImageLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 200))
        
        //MARK: - BUTTON UPLOAD
        view.addSubview(uploadButton)
        uploadButton.anchor(top: studentIdImageLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 125))
        
        //MARK: - HSTACKVIEW
        view.addSubview(hStackView)
        hStackView.anchor(top: uploadButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 50, left: 30, bottom: 0, right: 30))
        
    }
    
    @objc private func didUploadImageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
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

extension ProfileInfoTwoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        uploadButton.setImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
