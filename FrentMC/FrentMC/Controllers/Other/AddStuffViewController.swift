//
//  AddStuffViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/24/22.
//

import UIKit
import SwiftUI

class AddStuffViewController: UIViewController, UITextFieldDelegate {

    //MARK: - image picker
    
    let profileImageViewWidth: CGFloat = 25
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "frentImage").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = profileImageViewWidth / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
//    lazy var profileImageButton2: UIButton = {
//        var button = UIButton(type: .system)
//        button.backgroundColor = .clear
//        button.layer.cornerRadius = profileImageViewWidth / 2
//        button.layer.masksToBounds = true
////        button.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
//        return button
//    }()
    
    lazy private var profileImageButton : UIButton = {
        var button = ReusableButton(buttonTypes: .register)
        button.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.backgroundColor = .clear
        button.setTitle("Select Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy private var postBarangButton : UIButton = {
        var button = ReusableButton(buttonTypes: .signin)
        button.addTarget(self, action: #selector(postBarangButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor().getButtonColor()
        button.setTitle("Post Barang", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    
    //MARK: - label
    lazy private var nBarang : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Nama Barang")
        return label
    }()
    
    lazy private var kBarang : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Kondisi Barang Kamu")
        return label
    }()
    
    lazy private var lJurusan : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Jurusan")
        return label
    }()
    
    lazy private var dBarang : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Deskripsi Barang Tambahan")
        return label
    }()
    
    lazy private var sBarang : UILabel = {
        var label = ReusableLabel(labelType: .labelForm, labelString: "Estimasi Harga Sewa")
        return label
    }()

    
    //MARK: - textfield
    lazy private var nBarangTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Cth: Buku Pengantar Teknik Industri")
        tf.delegate = self
        return tf
    }()
    
    lazy private var kBarangTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Sering ga make barangnya?")
        tf.delegate = self
        return tf
    }()
    
    lazy private var lJurusanTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Jurusan Kamu?")
        tf.delegate = self
        return tf
    }()
    
    lazy private var dBarangTF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "Masukan Deskripsi Tambahan Lainnya Seperti:")
        tf.delegate = self
        return tf
    }()
    
    lazy private var harga1TF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "2 Minggu : 20,000")
        tf.delegate = self
        return tf
    }()
    
    lazy private var harga2TF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "3 Bulan : 50,000")
        tf.delegate = self
        return tf
    }()
    
    lazy private var harga3TF : UITextField = {
        var tf = ReusableTextField(tfType: .defaults, tfPholder: "6 Bulan : 75,000")
        tf.delegate = self
        return tf
        
    }()
    
    //MARK: - VIEWDIDLOAD
    
    
    @objc fileprivate func profileImageButtonTapped() {
        print("tapped")
        showImagePickerController()
//        showImagePickerControllerActionSheet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        addViews()
        constraintViews()
    }
    
    fileprivate func addViews() {
        view.addSubview(profileImageView)
        view.addSubview(profileImageButton)
        view.addSubview(nBarang)
        view.addSubview(nBarangTF)
        view.addSubview(kBarang)
        view.addSubview(kBarangTF)
        view.addSubview(lJurusan)
        view.addSubview(lJurusanTF)
        view.addSubview(dBarang)
        view.addSubview(dBarangTF)
        view.addSubview(sBarang)
        view.addSubview(harga1TF)
        view.addSubview(harga2TF)
        view.addSubview(harga3TF)
        view.addSubview(postBarangButton)
    }
    
    fileprivate func constraintViews() {
        
        profileImageView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 400, height: 150 ))
        profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -270).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        profileImageButton.anchor(top: profileImageView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        nBarang.anchor(top: profileImageButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 10))
        
        nBarangTF.anchor(top: nBarang.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
        kBarang.anchor(top: nBarangTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 10))
        
        kBarangTF.anchor(top: kBarang.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
        lJurusan.anchor(top: kBarangTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        lJurusanTF.anchor(top: lJurusan.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
        dBarang.anchor(top: lJurusanTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        dBarangTF.anchor(top: dBarang.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        sBarang.anchor(top: dBarangTF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        harga1TF.anchor(top: sBarang.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
        harga2TF.anchor(top: harga1TF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
        harga3TF.anchor(top: harga2TF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
        postBarangButton.anchor(top: harga3TF.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 10))
        
        
        
        
    }
    
    
    
    
    
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return AddStuffViewController()
            }
            .previewDevice("iPhone 13")
        }
    }

}

extension AddStuffViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    func showImagePickerControllerActionSheet() {
//        let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default){
//            (action) in
//            self.showImagePickerController(sourceType: .photoLibrary)
//        }
//        let cameraAction = UIAlertAction(title: "Take from camera", style: .default){
//            (action) in
//            self.showImagePickerController(sourceType: .camera)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        AlertService.showAlert(style: .actionSheet, title: "Choose Your Image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
//    }
    
//    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func postBarangButtonTapped() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
        
    }
}
