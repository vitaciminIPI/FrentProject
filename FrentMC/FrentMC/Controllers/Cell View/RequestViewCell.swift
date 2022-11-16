//
//  TableViewCell.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 18/10/22.
//

import UIKit

class RequestViewCell: UITableViewCell {
    
    lazy private var userImgView: UIImageView = {
        let imgView = UIImageView()
        let img = UIImage(systemName: "person.circle.fill")
        imgView.image = img
        return imgView
    }()
    
    lazy private var whatsAppImgView: UIImageView = {
        let imgView = UIImageView()
        let img = UIImage(named: "whatsAppLogo")
        imgView.image = img
        return imgView
    }()
    
    lazy private var titleGoodLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy private var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy private var majorAndUnivLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy private var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor().getCustomLightBlue()
        return view
    }()
    
    lazy private var vStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [userNameLabel, majorAndUnivLabel])
        stack.axis = .vertical
        stack.spacing =  5
        return stack
    }()
    
//    lazy private var hStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [userImgView, vStackView, whatsAppImgView])
//        stack.axis = .horizontal
//        stack.distribution = .fillProportionally
//        return stack
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        //MARK: - TITLE LABEL
        addSubview(titleGoodLabel)
        titleGoodLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        
        //MARK: - CONTAINER VIEW
        let halfHeight = 75
        addSubview(containerView)
        containerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: halfHeight))
        
        //MARK: - HSTACK
//        containerView.addSubview(hStackView)
//        hStackView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        //MARK: - USER IMAGE
        containerView.addSubview(userImgView)
        userImgView.anchor(top: nil, bottom: nil, leading: containerView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        userImgView.centerView(centerX: nil, centerY: containerView.centerYAnchor)
        
        //MARK: - VSTACK
        containerView.addSubview(vStackView)
        vStackView.anchor(top: nil, bottom: nil, leading: userImgView.trailingAnchor, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0))
        vStackView.centerView(centerX: containerView.centerXAnchor, centerY: containerView.centerYAnchor)
        
        //MARK: - WHATSAPP LOGO
        containerView.addSubview(whatsAppImgView)
        whatsAppImgView.anchor(top: nil, bottom: nil, leading: vStackView.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        whatsAppImgView.centerView(centerX: nil, centerY: containerView.centerYAnchor)
    }
    
    func setupGoods(goods: RequestGoods) {
        titleGoodLabel.text = goods.request_goods
        userNameLabel.text = goods.name
        
        let univ = goods.university
        let major = goods.major
        let demograph = "\(major ?? ""), \(univ ?? "")"
        majorAndUnivLabel.text = demograph
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
