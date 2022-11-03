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
        let origImage = UIImage(systemName: "plus")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintedImage, for: .normal)
        btn.tintColor = UIColor().getButtonColor()
        btn.setTitle("Tambah", for: .normal)
        btn.setTitleColor(UIColor().getButtonColor(), for: .normal)
        btn.addTarget(self, action: #selector(addItemTapped), for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
    private var listGoods = [
        Good(goodName: "Buku tulis", goodImage: "diamond_app_icon", location: "Jakarta", univName: "Binus", duration: "3 weeks", status: "Available", timeStamp: "", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: ""),
        Good(goodName: "Penggaris", goodImage: "diamond_app_icon", location: "Jakarta", univName: "UnTar", duration: "4 weeks", status: "Available", timeStamp: "", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: ""),
        Good(goodName: "Buku matematika", goodImage: "diamond_app_icon", location: "Bandung", univName: "ITB", duration: "2 weeks", status: "Available", timeStamp: "", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: "")
    ]
    
    let cellSpacingHeight: CGFloat = 10
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc func addItemTapped() {
        print("Tapped")
        self.navigationController?.pushViewController(AddStuffViewController(), animated: true)
    }
    
//    struct ViewControllerPreviews: PreviewProvider {
//        static var previews: some View {
//            UIViewControllerPreview {
//                return LentStatusViewController()
//            }
//            .previewDevice("iPhone 13")
//        }
//    }
//
}

extension LentStatusViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LentTableViewCell") as! LentTableViewCell
        let good = listGoods[indexPath.section]
//        tableView.deselectRow(at: indexPath, animated: true)
        cell.setGood(good: good)
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listGoods.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LentStatusDetailViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}
