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

    lazy private var studentIdImageLabel: UILabel = {
        let label = ReusableLabel(labelType: .labelForm, labelString: "Student ID Image")
        label.textColor = .white
        return label
    }()

    lazy private var errorLabel: UILabel = {
        var label = ReusableLabel(labelType: .errorMessage, labelString: "Error Message")
        label.textAlignment = .center
        return label
    }()

    //MARK: - TEXTFIELD
    lazy private var univNameTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: BINUS, UI, ITB, etc")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield: )), for: .editingChanged)
        return tf
    }()

    lazy private var majorTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: IT, SI, LAW, etc")
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield: )), for: .editingChanged)
        return tf
    }()

    lazy private var studentIdTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "ex: 1902372642")
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textFieldDidChange(textfield: )), for: .editingChanged)
        return tf
    }()


    //MARK: - BUTTON
    lazy private var backButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .skip)
        btn.setTitle("Back", for: .normal)
        btn.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return btn
    }()
        
    lazy private var nextButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .next)
        btn.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()

    lazy private var uploadButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .next)
        btn.setTitle("Upload Image Max 75 KB", for: .normal)
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

    //MARK: - SCROLL VIEW
    let scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.backgroundColor = UIColor().getCustomBlue()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()

    //MARK: - VIEW
    let container: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor().getBgColor()
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 60).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        return view
    }()

    //MARK: - CONSTS & VAR
    let registerVM = RegisterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.hidesBackButton = true
        setupScrollView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: nil, padding: .zero)
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(container)
        container.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor().getBgColor()
        errorLabel.isHidden = true
        
        //MARK: - TITLE
        container.addSubview(titleLabel)
        titleLabel.anchor(top: container.topAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
               
       //MARK: - SUBTITLE
       container.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
       
        //MARK: - UNIVNAME
        container.addSubview(univNameLabel)
        univNameLabel.anchor(top: subtitleLabel.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        
        container.addSubview(univNameTF)
        univNameTF.anchor(top: univNameLabel.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - MAJOR
        container.addSubview(majorLabel)
        majorLabel.anchor(top: univNameTF.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        
        container.addSubview(majorTF)
        majorTF.anchor(top: majorLabel.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - STUDENT ID
        container.addSubview(studentIdLabel)
        studentIdLabel.anchor(top: majorTF.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))

        container.addSubview(studentIdTF)
        studentIdTF.anchor(top: studentIdLabel.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - STUDENT ID IMAGE LABEL
        container.addSubview(studentIdImageLabel)
        studentIdImageLabel.anchor(top: studentIdTF.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
        //MARK: - BUTTON UPLOAD
        container.addSubview(uploadButton)
        uploadButton.anchor(top: studentIdImageLabel.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 125))
        
        //MARK: - ERROR LABEL
        container.addSubview(errorLabel)
        errorLabel.anchor(top: uploadButton.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
        //MARK: - HSTACKVIEW
        container.addSubview(hStackView)
        hStackView.anchor(top: errorLabel.bottomAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 50, left: 30, bottom: 0, right: 30))
        
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNextButton() {
        guard let univName = univNameTF.text else {return}
        guard let major = majorTF.text else {return}
        guard let nim = studentIdTF.text else {return}
//        let imageString = registerVM.imageEncode(imgView: imageView)
        let imageString = "asdfs"
//        print(imageString)
        
        registerVM.authenticateProfileTwo(univ: univName, major: major, nim: nim, image: imageString)
        registerVM.profileTwoCompletionHandler { [weak self] (status, message) in
            guard let self = self else {return}
            if status {
                self.errorLabel.isHidden = true
                let vc = TabBarViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                self.errorLabel.text = message
                self.errorLabel.isHidden = false
            }
        }
    }
    
    @objc private func didUploadImageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func textFieldDidChange(textfield: UITextField) {
        nextButton.isEnabled = !univNameTF.text!.isEmpty && !majorTF.text!.isEmpty && !studentIdTF.text!.isEmpty && (uploadButton.currentImage == nil)
    }
    
//    struct ViewControllerPreviews: PreviewProvider {
//        static var previews: some View {
//            UIViewControllerPreview {
//                return ProfileInfoTwoViewController()
//            }
//            .previewDevice("iPhone 13")
//        }
//    }
}

extension ProfileInfoTwoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        uploadButton.setImage(image, for: .normal)
        imageView.image = image
        uploadButton.backgroundColor = .clear
        uploadButton.imageView?.contentMode = .scaleAspectFit
        
        dismiss(animated: true, completion: nil)
    }
}
