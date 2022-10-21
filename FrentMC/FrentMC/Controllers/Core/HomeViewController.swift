//
//  ViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    //MARK: - TITLES
    var goods: Goods?
    var goodData: [Goods] = []

    lazy private var titles: UILabel = {
            let label = ReusableLabel(labelType: .titleBlack, labelString: "Hai FRent!")
            label.font = .systemFont(ofSize: 30, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
            return label
    }()
    
    lazy private var subtitles: UILabel = {
            let label = ReusableLabel(labelType: .titleBlack, labelString: "Cek barang yang kamu request")
            label.font = .systemFont(ofSize: 15, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
            return label
    }()
    
    lazy private var resubtitles: UILabel = {
            let label = ReusableLabel(labelType: .titleBlack, labelString: "Paling banyak disewa")
            label.font = .systemFont(ofSize: 15, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
            return label
    }()
    
    lazy private var resubtitles2: UILabel = {
            let label = ReusableLabel(labelType: .titleBlack, labelString: "Sekitaran Jakarta Nih")
            label.font = .systemFont(ofSize: 15, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
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
        return cv
    }()
    
    fileprivate let collectionView2: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.showsHorizontalScrollIndicator = false
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
        return cv
    }()
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        let datas = Goods()
        goodData = datas.initData()
    
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: nil),

            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil)
        ]
        
        setupUI()
        

    }

    func setupUI(){
        view.addSubview(titles)
        titles.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 95, left: -100, bottom: 0, right: 100))
        
        view.addSubview(subtitles)
        subtitles.anchor(top: titles.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: -20, bottom: 0, right: 90))
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: subtitles.topAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(resubtitles)
        resubtitles.anchor(top: collectionView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: -50, bottom: 0, right: 110))
        
        view.addSubview(collectionView2)
        collectionView2.backgroundColor = .white
        collectionView2.topAnchor.constraint(equalTo: resubtitles.topAnchor, constant: 30).isActive = true
        collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        collectionView2.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        view.addSubview(resubtitles2)
        resubtitles2.anchor(top: collectionView2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: -50, bottom: 0, right: 120))
        
        view.addSubview(collectionView3)
        collectionView3.backgroundColor = .white
        collectionView3.topAnchor.constraint(equalTo: resubtitles2.topAnchor, constant: 30).isActive = true
        collectionView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        collectionView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        collectionView3.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        collectionView3.delegate = self
        collectionView3.dataSource = self
        
        
    }

    @objc func didTapEditButton() {
        print("Upss lupa password ya")
    }
    
    @objc func didTapSearchButton() {
        print("Upss lupa password ya")
    }

}

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
