//
//  DetailBarangViewController.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 19/10/22.
//

import UIKit

class DetailBarangViewController: UIViewController {
    
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor().getCustomWhiteBG()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy private var topContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 410).isActive = true
        return view
    }()
    
    lazy private var midContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return view
    }()
    
    lazy private var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        return view
    }()
    
    lazy private var nameContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().getUserNameBG()
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topContainer, midContainer, bottomContainer])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    lazy private var vStackGood: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [goodLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    lazy private var vStackUser: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [userLabel, demographLabel])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    lazy private var hStackUser: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [userImageView, vStackUser])
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    lazy private var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceOneLabel, priceTwoLabel, priceThreeLabel])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy private var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "diamond_app_icon")
        imgView.contentMode = .scaleToFill
        imgView.heightAnchor.constraint(equalToConstant: 238).isActive = true
        return imgView
    }()
    
    lazy private var userImageView: UIImageView = {
        let imgView = UIImageView()
        let img = UIImage(named: "diamond_app_icon")
        imgView.image = img
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.layer.cornerRadius = 25
        return imgView
    }()
    
    lazy private var goodLabel: UILabel = {
        let label = ReusableLabel(labelType: .subtitleBlack, labelString: "Jas Lab")
        return label
    }()
    
    lazy private var priceLabel: UILabel = {
        let label = ReusableLabel(labelType: .subtitleBlack, labelString: "IDR 15.000 - 50.000")
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy private var userLabel: UILabel = {
        let label = ReusableLabel(labelType: .signIn, labelString: "Selvie")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy private var demographLabel: UILabel = {
        let label = ReusableLabel(labelType: .signIn, labelString: "Teknik Sipil, ITB")
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy private var estimateLabel: UILabel = {
        let label = ReusableLabel(labelType: .subtitleBlack, labelString: "💰 Estimasi harga sewa")
        return label
    }()
    
    lazy private var priceOneLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "2 Minggu - IDR 50.000"
        return label
    }()
    
    lazy private var priceTwoLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "3 Bulan - IDR 100.000"
        return label
    }()
    
    lazy private var priceThreeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "6 Bulan - IDR 200.000"
        return label
    }()
    
    lazy private var detailBarangLabel: UILabel = {
        let label = ReusableLabel(labelType: .subtitleBlack, labelString: "📖 Detail barang")
        return label
    }()
    
    lazy private var detailTF: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 14, weight: .regular)
        tv.translatesAutoresizingMaskIntoConstraints = true
        tv.sizeToFit()
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.text = "Sering dipakai\n\nJurusan Fisika, Kimia, Biologi, Arsitektur, Teknik Industri, Teknik Sipil\n\nKarangan Dita Karang edisi 20, terbitan tahun 2019\n\nAda beberapa lipatan dan coretan di 2-3 lembar halaman, kondisi masih layak pakai "
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = true
        tv.heightAnchor.constraint(equalToConstant: 210).isActive = true
        return tv
    }()
    
    lazy private var contactOwnerBtn: UIButton = {
        let btn = ReusableButton(buttonTypes: .contactOwner)
        btn.setTitle("Kontak Pemilik", for: .normal)
        return btn
    }()
    
    var fetchGoods : DisplayGoods?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+110)
    }
    
    private func setupScrollView() {
        //MARK: - SCROLL VIEW
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: nil, padding: .zero)
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        //MARK: - STACK VIEW
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, leading: nil, trailing: nil)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
    }
    
    private func setupContent() {
        //MARK: - TOP CONTAINER
        topContainer.addSubview(imageView)
        topContainer.addSubview(vStackGood)
        topContainer.addSubview(nameContainer)
        
        imageView.anchor(top: topContainer.topAnchor, bottom: nil, leading: topContainer.leadingAnchor, trailing: topContainer.trailingAnchor, padding: .zero, size: .init(width: 0, height: 238))
        vStackGood.anchor(top: imageView.bottomAnchor, bottom: nil, leading: topContainer.leadingAnchor, trailing: topContainer.trailingAnchor, padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        nameContainer.anchor(top: vStackGood.bottomAnchor, bottom: nil, leading: topContainer.leadingAnchor, trailing: topContainer.trailingAnchor, padding: .init(top: 20, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 60))
        
        nameContainer.addSubview(hStackUser)
        hStackUser.anchor(top: nameContainer.topAnchor, bottom: nameContainer.bottomAnchor, leading: nameContainer.leadingAnchor, trailing: nameContainer.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 5, right: 5))
        
        //MARK: - MID CONTAINER
        midContainer.addSubview(estimateLabel)
        midContainer.addSubview(priceStack)
        estimateLabel.anchor(top: midContainer.topAnchor, bottom: nil, leading: midContainer.leadingAnchor, trailing: midContainer.trailingAnchor, padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        priceStack.anchor(top: estimateLabel.bottomAnchor, bottom: nil, leading: midContainer.leadingAnchor, trailing: midContainer.trailingAnchor, padding: .init(top: 20, left: 50, bottom: 0, right: 30))
        
        //MARK: - BOTTOM CONTAINER
        bottomContainer.addSubview(detailBarangLabel)
        bottomContainer.addSubview(detailTF)
        bottomContainer.addSubview(contactOwnerBtn)
        detailBarangLabel.anchor(top: bottomContainer.topAnchor, bottom: nil, leading: bottomContainer.leadingAnchor, trailing: bottomContainer.trailingAnchor, padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        detailTF.anchor(top: detailBarangLabel.bottomAnchor, bottom: nil, leading: bottomContainer.leadingAnchor, trailing: bottomContainer.trailingAnchor, padding: .init(top: 20, left: 50, bottom: 0, right: 30))
        contactOwnerBtn.anchor(top: detailTF.bottomAnchor, bottom: bottomContainer.bottomAnchor, leading: bottomContainer.leadingAnchor, trailing: bottomContainer.trailingAnchor, padding: .init(top: 20, left: 30, bottom: 20, right: 30), size: .init(width: 0, height: 50))
    }
    
}
