//
//  GoodsCollectionViewCell.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/19/22.
//

import UIKit
import Foundation

class GoodsCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = UIImageView()
    
    lazy var labelGoodsName: UILabel = {
        let label = ReusableLabel(labelType: .profileForm, labelString: "")
        label.text = "Add your stuff"
        return label
    }()
    lazy var labelUnivName: UILabel = {
        let label = UILabel()
        label.text = "Add your univ"
        return label
    }()
    lazy var labelLocation: UILabel = {
        let label = UILabel()
        label.text = "Add your location"
        return label
    }()
    var labelPrice: UILabel = {
        let label = UILabel()
        label.text = "Add your label"
        return label
    }()
    
    //MARK: -EXTRA
    var labelMajor: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    var labelCondition: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    var containerViews = UIView()
    lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [labelGoodsName, labelUnivName, labelLocation, labelPrice])
        stack.axis = .vertical
        stack.spacing = 0
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

        addSubview(containerViews)
            
        containerViews.addSubview(stackView)
        containerViews.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)

//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.spacing = 5

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "frentImage")
        stackView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(top: containerViews.topAnchor, bottom: labelGoodsName.topAnchor, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor, padding: .zero, size: .init(width: 100, height: 100))
        
//        label food
        stackView.addArrangedSubview(labelGoodsName)
        labelGoodsName.translatesAutoresizingMaskIntoConstraints = false
        
//        labelGoodsName.text = ""
        labelGoodsName.font = UIFont.boldSystemFont(ofSize: 13)

        //label univ
        stackView.addArrangedSubview(labelUnivName)
        labelUnivName.translatesAutoresizingMaskIntoConstraints = false
//        labelUnivName.text = ""
        labelUnivName.font = UIFont.boldSystemFont(ofSize: 10)

        //label location
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
//        labelLocation.text = ""
        labelLocation.font = UIFont.boldSystemFont(ofSize: 10)
        stackView.addArrangedSubview(labelLocation)


        //label price
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
//        labelPrice.text = ""
        labelPrice.font = UIFont.boldSystemFont(ofSize: 10)
        stackView.addArrangedSubview(labelPrice)

        //stackview setting
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.anchor(top: imageView.bottomAnchor, bottom: containerViews.bottomAnchor, leading: containerViews.leadingAnchor, trailing: containerViews.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 5))
    }
    
    
    
    func setupDisplayGoods(goods: DisplayGoods) {
        print(goods)
        
        let urlString = URL(string: goods.image_goods?[0].url ?? "")!
        getDataFromURL(from: urlString) { data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        labelGoodsName.text = goods.name
        labelUnivName.text = "🎓 \(goods.major ?? "0")"
        labelLocation.text = "📌 \(goods.location? [0] ?? "0")"
        labelPrice.text = "~IDR \(goods.rent_first ?? "0")"
    }
    
    func getDataFromURL(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

