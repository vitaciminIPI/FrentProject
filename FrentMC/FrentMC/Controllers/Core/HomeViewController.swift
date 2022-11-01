//
//  ViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    //MARK: - PROPERTIES
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    //MARK: - ScrollView
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        view.autoresizingMask = .flexibleHeight
//        view.bounces = true
        return view
    }()
    
    //MARK: - BUTTON
    lazy private var searchButton: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(systemName: "magnifyingglass")
        let tintedImg = img?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintedImg, for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    lazy private var notificationButton: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(systemName: "bell")
        let tintedImg = img?.withRenderingMode(.alwaysTemplate)
        btn.setImage(img, for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    lazy private var hStackView: UIStackView = {
        let stack =  UIStackView(arrangedSubviews: [searchButton, notificationButton])
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    lazy private var contentStackView: UIStackView = {
        let spacer = UIView()
        let stack = UIStackView(arrangedSubviews: [titles, spacer, hStackView])
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    
    //MARK: - TITLES
    var goods: Goods?
    var goodData: [Goods] = []

    //MARK: - LABEL
    lazy private var titles: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Hai FRent!")
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor().getTitleColor()
        return label
    }()
    
    lazy private var subtitles: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Cek barang yang kamu request")
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.textColor = UIColor().getTitleColor()
        return label
    }()
    
    lazy private var resubtitles: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Paling banyak disewa")
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.textColor = UIColor().getTitleColor()
        return label
    }()
    
    lazy private var resubtitles2: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Sekitaran Jakarta Nih")
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.textColor = UIColor().getTitleColor()
        return label
    }()
    
    //MARK: - CollectionView
    fileprivate let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.showsHorizontalScrollIndicator = false
        cv.layer.shadowColor = UIColor.gray.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        cv.layer.shadowRadius = 2.0
        cv.layer.shadowOpacity = 1.0
        cv.layer.masksToBounds = false
        cv.layer.backgroundColor = UIColor.clear.cgColor
        
        return cv
    }()
    
    fileprivate let collectionView2: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.showsHorizontalScrollIndicator = false
        cv.layer.shadowColor = UIColor.gray.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        cv.layer.shadowRadius = 2.0
        cv.layer.shadowOpacity = 1.0
        cv.layer.masksToBounds = false
        cv.layer.backgroundColor = UIColor.clear.cgColor
        return cv
    }()
    
    fileprivate let collectionView3: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.collectionView?.showsHorizontalScrollIndicator = false
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.showsHorizontalScrollIndicator = false
        cv.layer.shadowColor = UIColor.gray.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        cv.layer.shadowRadius = 2.0
        cv.layer.shadowOpacity = 1.0
        cv.layer.masksToBounds = false
        cv.layer.backgroundColor = UIColor.clear.cgColor
        return cv
    }()
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        let datas = Goods()
        goodData = datas.initData()
    
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .label

        
        //BUTTON
//        navigationItem.rightBarButtonItems = [
//            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: nil),
//
//            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil)
//        ]
        
        setupUI()
        

    }

    //MARK: - SETUPUI ANCHOR
    func setupUI(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
//        view.addSubview(titles)
//        titles.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 95, left: -100, bottom: 0, right: 100))
        view.addSubview(contentStackView)
        contentStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 70, left: 15, bottom: 0, right: 15))
        
        containerView.addSubview(subtitles)
        subtitles.anchor(top: containerView.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: -20, bottom: 0, right: 100))
        
        containerView.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: subtitles.topAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.75).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        containerView.addSubview(resubtitles)
        resubtitles.anchor(top: collectionView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: -50, bottom: 0, right: 130))
        
        containerView.addSubview(collectionView2)
        collectionView2.backgroundColor = .clear
        collectionView2.topAnchor.constraint(equalTo: resubtitles.topAnchor, constant: 10).isActive = true
        collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView2.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.75).isActive = true
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        containerView.addSubview(resubtitles2)
        resubtitles2.anchor(top: collectionView2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: -50, bottom: 0, right: 130))
        
        containerView.addSubview(collectionView3)
        collectionView3.backgroundColor = .clear
        collectionView3.topAnchor.constraint(equalTo: resubtitles2.topAnchor, constant: 10).isActive = true
        collectionView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView3.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.75).isActive = true
        
        collectionView3.delegate = self
        collectionView3.dataSource = self
        
        
    }

    //MARK: - FUNGSI BUTTON
    @objc func didTapNotifButton() {
        print("Upss lupa password ya")
    }
    
    @objc func didTapSearchButton() {
        print("Upss lupa password ya")
    }

}

    //MARK: - EXTENSION
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GoodsCollectionViewCell
        cell.autolayoutCell()
        cell.good = goodData[indexPath.row]
        return cell
    }
    
    
}


