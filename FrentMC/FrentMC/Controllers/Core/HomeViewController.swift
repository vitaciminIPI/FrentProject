//
//  ViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit
import RxSwift
import RxCocoa



class HomeViewController: UIViewController {

    var goods: Goods!
    var user: UserModels!
    
    
    //MARK: - PROPERTIES
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    //MARK: - INSTANCE ADDSTUFF
    private let addStuffViewModel = AddStuffViewModel()
    
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
//    var goods: Goods?
    var goodData: [Goods] = []

    //MARK: - LABEL
    lazy private var titles: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Hai FRent! 👋")
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor().getTitleColor()
        return label
    }()
    
    lazy private var subtitles: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Cek barang yang kamu request 👇")
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.textColor = UIColor().getTitleColor()
        return label
    }()
    
    lazy private var resubtitles: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Paling banyak disewa 👀")
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.textColor = UIColor().getTitleColor()
        return label
    }()
    
    lazy private var resubtitles2: UILabel = {
        let label = ReusableLabel(labelType: .titleBlack, labelString: "Sekitaran Jakarta Nih 🌎")
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
        layout.itemSize = CGSize(width: 125, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
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
        layout.itemSize = CGSize(width: 125, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
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
        layout.itemSize = CGSize(width: 125, height: 200)

        layout.collectionView?.showsHorizontalScrollIndicator = false
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
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
        
        setupUI()
//        print(self.userDummy.major)
        //BIND COLLECTION
        bindCollection()
        bindCollection2()
//        let obj = addStuffViewModel.displayGoods2.subscribe { Element in
//            print(Element)
//        }
        bindCollection3()

    }
    
    private let bag = DisposeBag()

    //MARK: - SETUPUI ANCHOR
    func setupUI(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        view.addSubview(contentStackView)
        contentStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 70, left: 15, bottom: 0, right: 15))
        
        containerView.addSubview(subtitles)
        subtitles.anchor(top: containerView.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: -20, bottom: 0, right: 100))
        
        
        //MARK: - COLLECTION 1
        containerView.addSubview(collectionView)
        collectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: "GoodsCollectionViewCell")
//        collectionView.register(UINib(nibName: "GoodsCollectionViewCell", bundle: nil), forCellWitcellhReuseIdentifier: "GoodsCollectionViewCell")

        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: subtitles.topAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.75).isActive = true
        
//        collectionView.delegate = self
//        collectionView.dataSource = self

        //MARK: - COLLECTION 2
        containerView.addSubview(resubtitles)
        resubtitles.anchor(top: collectionView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: -50, bottom: 0, right: 130))
        
        containerView.addSubview(collectionView2)
        collectionView2.register(GoodsCollectionViewCell2.self, forCellWithReuseIdentifier: "GoodsCollectionViewCell2")
        collectionView2.backgroundColor = .clear
        collectionView2.topAnchor.constraint(equalTo: resubtitles.topAnchor, constant: 10).isActive = true
        collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView2.heightAnchor.constraint(equalTo: collectionView2.widthAnchor, multiplier: 0.75).isActive = true
        
//        collectionView2.delegate = self
//        collectionView2.dataSource = self
        
        
        //MARK: - COLLECTION 3
        containerView.addSubview(resubtitles2)
        resubtitles2.anchor(top: collectionView2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: -50, bottom: 0, right: 130))

        containerView.addSubview(collectionView3)
        collectionView3.register(GoodsCollectionViewCell3.self, forCellWithReuseIdentifier: "GoodsCollectionViewCell3")
        collectionView3.backgroundColor = .clear
        collectionView3.topAnchor.constraint(equalTo: resubtitles2.topAnchor, constant: 10).isActive = true
        collectionView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView3.heightAnchor.constraint(equalTo: collectionView3.widthAnchor, multiplier: 0.75).isActive = true
        
//        collectionView3.delegate = self
//        collectionView3.dataSource = self
        
        
    }

    //MARK: - FUNGSI BUTTON
    @objc func didTapNotifButton() {
        print("Upss lupa password ya")
    }
    
    @objc func didTapSearchButton() {
        print("Upss lupa password ya")
    }
    
    //MARK: - BINDCOLLECTIONVIEW
    private func bindCollection() {
        addStuffViewModel.displayGoods.bind(to: collectionView.rx.items(cellIdentifier: "GoodsCollectionViewCell", cellType: GoodsCollectionViewCell.self)) { (row, model,cell)
            in
            let good = model.fields
            cell.setupDisplayGoods(goods: good!)
        }.disposed(by: bag)
        
        collectionView.rx.modelSelected(DataFieldDisplayGood.self).bind {goods in

        }.disposed(by: bag)
        addStuffViewModel.fetchDisplayGoods()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath){
        self.navigationController?.pushViewController(DetailBarangViewController(), animated: true)
    }
    
    //MARK: -BINDING 2
    private func bindCollection2() {
        
        let userDummy = UserModels(user_id: "USR-0001", name: "Ismawan", phone_number: "625882136099", email: "ismawan@gmail.com", password: "123456789", confirmPassword: "123456789", nim: "2301941952", major: "Teknik Informatika", entryYear: "2019", university: "Binus", location: "Jakarta", student_card: "")
        
        addStuffViewModel.displayGoods2.bind(to: collectionView2.rx.items(cellIdentifier: "GoodsCollectionViewCell2", cellType: GoodsCollectionViewCell2.self)) { (row, model,cell)
            in
            let good = model.fields
            cell.setupDisplayGoods(goods: good!)
        }.disposed(by: bag)

        collectionView2.rx.modelSelected(DataFieldDisplayGood.self).bind {goods in

        }.disposed(by: bag)
        addStuffViewModel.fetchDisplayGoods2(user: userDummy)
    }

    //MARK: -BINDING 3
    private func bindCollection3() {
        addStuffViewModel.displayGoods3.bind(to: collectionView3.rx.items(cellIdentifier: "GoodsCollectionViewCell3", cellType: GoodsCollectionViewCell3.self)) { (row, model,cell)
            in
            let good = model.fields
            cell.setupDisplayGoods(goods: good!)
        }.disposed(by: bag)

        collectionView3.rx.modelSelected(DataFieldDisplayGood.self).bind {goods in

        }.disposed(by: bag)
        addStuffViewModel.fetchDisplayGoods3()
    }
    
}

    //MARK: - EXTENSION
//extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 125, height: 200)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return goodData.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GoodsCollectionViewCell
//        cell.autolayoutCell()
//        cell.good = goodData[indexPath.row]
//        return cell
//    }
//

//}


