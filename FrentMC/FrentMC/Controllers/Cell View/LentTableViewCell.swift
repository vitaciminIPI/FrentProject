//
//  LentTableViewCell.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 11/10/22.
//

import UIKit

class LentTableViewCell: UITableViewCell {
    var goodsImage = UIImageView()
    var goodsName = UILabel()
    var location = UILabel()
    var univName = UILabel()
    var duration = UILabel()
    var status = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGood(good: Good) {
        goodsImage.image = UIImage(named: good.goodImage)
        goodsName.text = good.goodName
        location.text = good.location
        univName.text = good.univName
        duration.text = good.duration
        status.text = good.status
    }
    
    func setupCellUI() {
        addSubview(goodsImage)
        addSubview(goodsName)
        addSubview(location)
        addSubview(univName)
        addSubview(duration)
        addSubview(status)
        
        labelStyle()
        
        goodsImage.anchor(top: topAnchor, bottom: status.topAnchor, leading: leadingAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 0), size: .init(width: 100, height: 0))
        goodsName.anchor(top: topAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        location.anchor(top: goodsName.bottomAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        univName.anchor(top: location.bottomAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        duration.anchor(top: univName.bottomAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        status.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 40))
    }
    
    func labelStyle() {
        goodsName.font = .systemFont(ofSize: 16, weight: .bold)
        location.font = .systemFont(ofSize: 12, weight: .regular)
        univName.font = .systemFont(ofSize: 12, weight: .regular)
        duration.font = .systemFont(ofSize: 12, weight: .regular)
        status.font = .systemFont(ofSize: 16, weight: .bold)
        status.backgroundColor = UIColor().getButtonColor()
        status.textColor = .white
        status.textAlignment = .center
        status.layer.cornerRadius = 20
    }
    
}
