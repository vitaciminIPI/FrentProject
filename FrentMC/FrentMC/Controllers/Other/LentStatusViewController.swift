//
//  LentStatusViewController.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 11/10/22.
//

import UIKit
import SwiftUI

class LentStatusViewController: UIViewController {

    lazy private var tableView: UITableView = {
       let tv = UITableView()
        tv.rowHeight = 150
        tv.register(LentTableViewCell.self, forCellReuseIdentifier: "LentTableViewCell")
        return tv
    }()
    
    lazy private var rightBarButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.setTitle("Add", for: .normal)
        btn.addTarget(self, action: #selector(addItemTapped), for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
    var listGoods = [
        Good(goodName: "Buku tulis", goodImage: "diamond_app_icon", location: "Jakarta", univName: "Binus", duration: "3 weeks", status: "Available"),
        Good(goodName: "Penggaris", goodImage: "diamond_app_icon", location: "Jakarta", univName: "UnTar", duration: "4 weeks", status: "Available"),
        Good(goodName: "Buku matematika", goodImage: "diamond_app_icon", location: "Bandung", univName: "ITB", duration: "2 weeks", status: "Available")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegateTableView()
        setupUI()
        barButtonItem()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    private func setDelegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func barButtonItem() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItemTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc func addItemTapped() {
        print("Tapped")
    }
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return LentStatusViewController()
            }
            .previewDevice("iPhone 13")
        }
    }
    
}

extension LentStatusViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LentTableViewCell") as! LentTableViewCell
        let good = listGoods[indexPath.row]
        cell.setGood(good: good)
        return cell
    }
    
    
}
