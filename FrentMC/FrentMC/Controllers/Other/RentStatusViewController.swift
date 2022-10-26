//
//  RentStatusViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/24/22.
//

import Foundation
import UIKit
import SwiftUI

//class RentStatusViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
class RentStatusViewController: UIViewController {
    
    lazy private var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 150
        tv.register(RentTableViewCell.self, forCellReuseIdentifier: "RentTableViewCell")
        return tv
    }()
    
    //MARK: - LISTGOODS
    private var listGoods = [
        Good(goodName: "Buku tulis", goodImage: "diamond_app_icon", location: "Jakarta", univName: "Binus", duration: "3 weeks", status: "Available"),
        Good(goodName: "Penggaris", goodImage: "diamond_app_icon", location: "Jakarta", univName: "UnTar", duration: "4 weeks", status: "Available"),
        Good(goodName: "Buku matematika", goodImage: "diamond_app_icon", location: "Bandung", univName: "ITB", duration: "2 weeks", status: "Available")
    ]
    
    private var listGoods2 = [
        Good(goodName: "Buku gambar", goodImage: "diamond_app_icon", location: "Jakarta", univName: "Binus", duration: "3 weeks", status: "Available"),
        Good(goodName: "jangka", goodImage: "diamond_app_icon", location: "Jakarta", univName: "UnTar", duration: "4 weeks", status: "Available"),
        Good(goodName: "Buku fisika", goodImage: "diamond_app_icon", location: "Bandung", univName: "ITB", duration: "2 weeks", status: "Available")
    ]
    
    let cellSpacingHeight: CGFloat = 10
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rowsToDisplay.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = rowsToDisplay[indexPath.row]
//        return cell
//    }
    
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Sedang disewa", "Sudah di kembalikan"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(RentStatusViewController.self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    //    @objc fileprivate func handleSegmentChange(){
    //        print(segmentedControl.selectedSegmentIndex)
    //
    //        switch segmentedControl.selectedSegmentIndex{
    //        case 0:
    //            rowsToDisplay = games
    //        case 1:
    //            rowsToDisplay = devices
    //        default:
    //            rowsToDisplay = devices
    //        }
    //        tableView.reloadData()
    //    }
    
    @objc fileprivate func handleSegmentChange(){
        print(segmentedControl.selectedSegmentIndex)
        
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            rowsToDisplay = listGoods
        case 1:
            rowsToDisplay = listGoods2
        default:
            rowsToDisplay = listGoods2
        }
        tableView.reloadData()
    }
    
    //    let tableView2 = UITableView(frame: .zero, style: .plain)
    //
    //    let games = ["1","2", "3", "4", "5"]
    //
    //    let devices = ["iPad","iPhone", "iMac", "iPark", "iLove"]
    
    //master array
    //    lazy var rowsToDisplay = games
    
    lazy var rowsToDisplay = listGoods
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "Rent"
        
        //        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        //        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        //
        //        paddedStackView.isLayoutMarginsRelativeArrangement = true
        
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
        
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
    }
    
    //MARK: -TESTING
}

extension RentStatusViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentTableViewCell") as! RentTableViewCell
        let good = rowsToDisplay[indexPath.section]
        //        tableView.deselectRow(at: indexPath, animated: true)
        cell.setGood(good: good)
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rowsToDisplay.count
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
    
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return RentStatusViewController()
            }
            .previewDevice("iPhone 13")
        }
    }
    
    
    
}




