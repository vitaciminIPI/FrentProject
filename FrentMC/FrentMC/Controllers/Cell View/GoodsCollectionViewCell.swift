//
//  GoodsCollectionViewCell.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/19/22.
//

import UIKit

class GoodsCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = UIImageView()
    lazy var labelGoodsName: UILabel = {
        let label = UILabel()
        label.text = "asfsdaf"
        return label
    }()
    lazy var labelUnivName: UILabel = {
        let label = UILabel()
        label.text = "asfsdaf"
        return label
    }()
    lazy var labelLocation: UILabel = {
        let label = UILabel()
        label.text = "asfsdaf"
        return label
    }()
    var labelPrice: UILabel = {
        let label = UILabel()
        label.text = "asfsdaf"
        return label
    }()
    var containerViews = UIView()
    lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [labelGoodsName, labelUnivName, labelLocation, labelPrice])
        stack.axis = .vertical
        stack.spacing = 1
        return stack
    }()
    func autolayoutCell() {

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var good: Goods?{
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        containerViews.backgroundColor = .systemGray6
        containerViews.layer.borderWidth = 1
        containerViews.layer.borderColor = UIColor(red:192/255, green:192/255, blue:192/255, alpha: 1).cgColor
        containerViews.layer.cornerRadius = 10
        
//        containerViews.backgroundColor = .lightGray
        addSubview(containerViews)
        containerViews.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "frentImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerViews.addSubview(imageView)
        imageView.anchor(top: containerViews.topAnchor, bottom: nil, leading: containerViews.leadingAnchor, trailing: containerViews.trailingAnchor, padding: .zero, size: .init(width: 0, height: 100))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        containerViews.addSubview(stackView)
        
//        label food
        labelGoodsName.translatesAutoresizingMaskIntoConstraints = false
        labelGoodsName.text = "goods name"
        labelGoodsName.font = UIFont.boldSystemFont(ofSize: 12)
        stackView.addArrangedSubview(labelGoodsName)

//
        //label univ
        labelUnivName.translatesAutoresizingMaskIntoConstraints = false
        labelUnivName.text = "goods name"
        labelUnivName.font = UIFont.boldSystemFont(ofSize: 10)
        stackView.addArrangedSubview(labelUnivName)
//
//
        //label location
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        labelLocation.text = "goods name"
        labelLocation.font = UIFont.boldSystemFont(ofSize: 10)
        stackView.addArrangedSubview(labelLocation)


        //label price
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.text = "goods name"
        labelPrice.font = UIFont.boldSystemFont(ofSize: 10)
        stackView.addArrangedSubview(labelPrice)


        //stackview setting
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.anchor(top: imageView.bottomAnchor, bottom: containerViews.bottomAnchor, leading: containerViews.leadingAnchor, trailing: containerViews.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        if let data = good {

            imageView.image = UIImage(named: data.imageView!)
            
            labelGoodsName.text = data.goodsName ?? ""

            labelUnivName.text = data.univName ?? ""

            labelLocation.text = data.location ?? ""

            labelPrice.text = data.price ?? ""
        }
    }
}

