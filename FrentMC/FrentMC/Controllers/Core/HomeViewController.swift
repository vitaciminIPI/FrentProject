//
//  ViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - TITLES
    lazy private var titles: UILabel = {
            let label = ReusableLabel(labelType: .titleBlack, labelString: "Hai FRent!")
            label.font = .systemFont(ofSize: 30, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
            return label
    }()
    
    //MARK: - BUTTON
    lazy private var searchButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.tintColor = .black
//        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()

    
    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .systemBackground
        setupUI()
        

    }

    func setupUI(){
        view.addSubview(titles)
        titles.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 95, left: -100, bottom: 0, right: 100))
        
        view.addSubview(searchButton)
        searchButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 70, left: 100, bottom: 0, right: -100))
    }

    @objc func didTapEditButton() {
        print("Upss lupa password ya")
    }
    
    @objc func didTapSearchButton() {
        print("Upss lupa password ya")
    }

}

