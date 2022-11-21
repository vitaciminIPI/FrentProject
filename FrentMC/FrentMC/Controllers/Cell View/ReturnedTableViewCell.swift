//
//  ReturnedTableViewCell.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 20/11/22.
//

import UIKit
import RxSwift

class ReturnedTableViewCell: UITableViewCell {
    var goodsImage = UIImageView()
    var goodsName = UILabel()
    var location = UILabel()
    var univName = UILabel()
    var duration = UILabel()
    var status = UILabel()
    var timeStamp = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHistory(history: History) {
        let urlString = URL(string: history.imageGood?[0].url ?? "")!
            getDataFromURL(from: urlString) { data, response, error in
                guard let data = data, error == nil else {return}
                DispatchQueue.main.async {
                    self.goodsImage.image = UIImage(data: data)
                }
        }
        goodsName.text = history.goodName?[0]
        location.text = history.location?[0]
        univName.text = history.ownerName?[0]
        duration.text = history.university?[0]
    }
    
    func setupCellUI() {
        addSubview(goodsImage)
        addSubview(goodsName)
        addSubview(location)
        addSubview(univName)
        addSubview(duration)
        addSubview(status)
        addSubview(timeStamp)
        
        labelStyle()
        
        goodsImage.anchor(top: topAnchor, bottom: status.topAnchor, leading: leadingAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 0), size: .init(width: 100, height: 0))
        goodsName.anchor(top: topAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        location.anchor(top: goodsName.bottomAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        univName.anchor(top: location.bottomAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        duration.anchor(top: univName.bottomAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        status.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: -220, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        timeStamp.anchor(top: duration.bottomAnchor, bottom: nil, leading: goodsImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 22, left: 140, bottom: 0, right: 0), size: .init(width: 0, height: 40))
    }
    
    func labelStyle() {
        goodsName.font = .systemFont(ofSize: 16, weight: .bold)
        location.font = .systemFont(ofSize: 12, weight: .regular)
        univName.font = .systemFont(ofSize: 12, weight: .regular)
        duration.font = .systemFont(ofSize: 12, weight: .regular)
        status.font = .systemFont(ofSize: 14, weight: .bold)
        status.backgroundColor = .systemGray3
        status.textColor = .white
        status.textAlignment = .center
        status.layer.cornerRadius = 20
        timeStamp.font = .systemFont(ofSize: 14, weight: .bold)
        timeStamp.textColor = .systemRed
        timeStamp.textAlignment = .center
    }
    
    func getDataFromURL(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
    
    func getStringFrom(strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: strDate) ?? Date()

        let outformatter = DateFormatter()
        outformatter.dateFormat = "MMM d yyyy"
        return outformatter.string(from: date)
    }
    
}
