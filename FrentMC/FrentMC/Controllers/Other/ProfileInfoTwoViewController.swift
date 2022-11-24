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
//        label.font = .systemFont(ofSize: 20)
       return label
   }()
       
   lazy private var subtitleLabel: UILabel = {
       let label = ReusableLabel(labelType: .subtitle, labelString: "Your one click away study equipment rent! Rent everywhere and connect.")
       label.numberOfLines = 3
//       label.font = .systemFont(ofSize: 16)
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
    
    //MARK: - VIEW
    lazy private var indicatorContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isOpaque = false
        return view
    }()
    
    let container: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor().getBgColor()
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 60).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        return view
    }()
    
    //MARK: - SCROLL VIEW
    let scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.backgroundColor = UIColor().getCustomBlue()
        scroll.showsVerticalScrollIndicator = false
        return scroll
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
    
    //MARK: - ACTIVITY INDICATOR
    lazy private var indicator : UIActivityIndicatorView = {
       let ind = UIActivityIndicatorView()
        ind.style = .large
        ind.color = .white
        return ind
    }()
    
    //MARK: - CONSTS & VAR
    let registerVM = RegisterViewModel()
    var user: UserModels?
    let apiManager = APICaller()
//    var userX = UserModels(user_id: "USR-X", name: "mrx", phone_number: "1313131", email: "testter333@gmail.com", password: "sfasd", confirmPassword: "sdfsa", nim: "", major: "", entryYear: "2021", university: "", location: "ssdfs", student_card: "", request_goods: "", owner_id: <#[String]?#>)

    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupScrollView()
        setupUI()
        print(user?.location ?? "")
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
        indicatorContainer.isHidden = true
        indicator.hidesWhenStopped = true
        
        view.addSubview(indicatorContainer)
        indicatorContainer.addSubview(indicator)
        
        //MARK: - INDICATOR ACTIVITY
        indicatorContainer.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        indicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        indicator.centerView(centerX: indicatorContainer.centerXAnchor, centerY: indicatorContainer.centerYAnchor)
//        indicator.startAnimating() -> muncul indicator setelah di start animating
        
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
        indicatorContainer.isHidden = false
        indicator.startAnimating()
        guard let univName = univNameTF.text else {return}
        guard let major = majorTF.text else {return}
        guard let nim = studentIdTF.text else {return}
        guard let image = imageView.image else {return}
        
        registerVM.profileTwoCompletionHandler { [weak self] (status, message) in
            guard let self = self else {return}
            if status {
                print("data valid")
                self.errorLabel.isHidden = true
                self.user?.university = univName
                self.user?.nim = nim
                self.user?.major = major

                self.apiManager.updateUser(user: self.user!, image: image)
                self.apiManager.createRole(user: self.user!) { roleId in
                    self.apiManager.createOwner(roleId: roleId)
                }
                self.indicator.stopAnimating()
                self.indicatorContainer.isHidden = true
                
                let vc = TabBarViewController()
                vc.user = self.user
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                print("data invalid")
                self.indicator.stopAnimating()
                self.indicatorContainer.isHidden = true
                self.errorLabel.text = message
                self.errorLabel.isHidden = false
            }
        }
        registerVM.authenticateProfileTwo(univ: univName, major: major, nim: nim, image: image)
    }
    
    @objc private func textFieldDidChange(textfield: UITextField) {
        nextButton.isEnabled = !univNameTF.text!.isEmpty && !majorTF.text!.isEmpty && !studentIdTF.text!.isEmpty
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
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}
