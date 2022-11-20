//
//  RentStatusViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/24/22.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift
import RxCocoa

//class RentStatusViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
class RentStatusViewController: UIViewController {
    
    lazy private var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 150
        tv.register(RentTableViewCell.self, forCellReuseIdentifier: "RentTableViewCell")
        return tv
    }()
    
    lazy private var tableViewHistory: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 150
        tv.register(ReturnedTableViewCell.self, forCellReuseIdentifier: "ReturnedTableViewCell")
        return tv
    }()
    
    //MARK: - LISTGOODS
    private var listGoods = [
        Good(goods_id: "", goodName: "Buku tulis", goodImage: "diamond_app_icon", location: "Jakarta", univName: "Binus", duration: "3 weeks", status: "Harus Kembali Dalam", timeStamp: "1D: 5H: 23M: 12S", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: ""),
        Good(goods_id: "", goodName: "Penggaris", goodImage: "diamond_app_icon", location: "Jakarta", univName: "UnTar", duration: "4 weeks", status: "Harus Kembali Dalam", timeStamp: "1D: 5H: 23M: 12S", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: ""),
        Good(goods_id: "", goodName: "Buku matematika", goodImage: "diamond_app_icon", location: "Bandung", univName: "ITB", duration: "2 weeks", status: "Harus Kembali Dalam", timeStamp: "1D: 5H: 23M: 12S", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: "")
    ]
    
    private var listGoods2 = [
        Good(goods_id: "", goodName: "Buku gambar", goodImage: "diamond_app_icon", location: "Jakarta", univName: "Binus", duration: "3 weeks", status: "Harus Kembali Dalam", timeStamp: "1D: 5H: 23M: 12S", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: ""),
        Good(goods_id: "", goodName: "jangka", goodImage: "diamond_app_icon", location: "Jakarta", univName: "UnTar", duration: "4 weeks", status: "Harus Kembali Dalam", timeStamp: "1D: 5H: 23M: 12S", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: ""),
        Good(goods_id: "", goodName: "Buku fisika", goodImage: "diamond_app_icon", location: "Bandung", univName: "ITB", duration: "2 weeks", status: "Harus Kembali Dalam", timeStamp: "1D: 5H: 23M: 12S", condition: "", major: "", description: "", rentFirst: "", rentSecond: "", rentThird: "")
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
    
    lazy private var containerOne: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy private var containerTwo: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Sedang disewa", "Sudah di kembalikan"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange(sender: )), for: .valueChanged)
        return sc
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl])
        stackView.axis = .vertical
        return stackView
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
    
    @objc func handleSegmentChange(sender: UISegmentedControl){
        print(segmentedControl.selectedSegmentIndex)
        
        switch segmentedControl.selectedSegmentIndex{
        case 0:
//            rowsToDisplay = listGoods
            setupUIViewOne()
//            contOne()
        case 1:
//            rowsToDisplay = listGoods2
            setupUIViewTwo()
//            contTwo()
        default:
//            rowsToDisplay = listGoods2
            break
        }
//        tableView.reloadData()
    }
    
    //    let tableView2 = UITableView(frame: .zero, style: .plain)
    //
    //    let games = ["1","2", "3", "4", "5"]
    //
    //    let devices = ["iPad","iPhone", "iMac", "iPark", "iLove"]
    
    //master array
    //    lazy var rowsToDisplay = games
    
    lazy var rowsToDisplay = listGoods
    private let vm = OrdersViewModel()
    private let hvm = HistoryViewModels()
    private let bag = DisposeBag()
    
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        setupUI()
//        contOne()
        setupUIViewOne()
//        setupUIViewTwo()
    }
    
    func contOne() {
        view.addSubview(containerOne)
        containerOne.anchor(top: segmentedControl.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        containerOne.backgroundColor = .blue
    }
    
    func contTwo() {
        view.addSubview(containerTwo)
        containerTwo.anchor(top: segmentedControl.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        containerTwo.backgroundColor = .red
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Rent"

        view.addSubview(segmentedControl)
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    func setupUIViewOne() {
//        navigationItem.title = "Rent"
        
        //        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        //        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        //
        //        paddedStackView.isLayoutMarginsRelativeArrangement = true
        
//        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
//
//        stackView.axis = .vertical
        
//        view.addSubview(stackView)
//        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
        view.addSubview(tableView)
        tableView.anchor(top: segmentedControl.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        bindTable()
    }
    
    func setupUIViewTwo() {
        navigationItem.title = "Rent"
        
        //        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        //        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        //
        //        paddedStackView.isLayoutMarginsRelativeArrangement = true
        
//        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableViewHistory])
//
//        stackView.axis = .vertical
//
//        view.addSubview(stackView)
//        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
        view.addSubview(tableViewHistory)
        tableViewHistory.anchor(top: segmentedControl.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        self.tableViewHistory.delegate = nil
        self.tableViewHistory.dataSource = nil
        bindTableHistory()
    }
    
    func bindTable() {
        vm.orders.bind(to: tableView.rx.items(cellIdentifier: "RentTableViewCell", cellType: RentTableViewCell.self)) { (row, model, cell) in
            guard let good = model.fields else {return}
            cell.setGood(good: good)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(DataFieldOrders.self).bind { data in
            print(data.fields?.goodName ?? "")
        }.disposed(by: bag)
        
        tableView.refreshControl?.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] in
            self?.vm.getAllOrders()
        }).disposed(by: bag)
        
        vm.getAllOrders()
    }
    
    func bindTableHistory() {
        hvm.historyUsers.bind(to: tableViewHistory.rx.items(cellIdentifier: "ReturnedTableViewCell", cellType: ReturnedTableViewCell.self)) { (row, model, cell) in
            guard let history = model.fields else {return}
            cell.setHistory(history: history)
        }.disposed(by: bag)
        
        tableViewHistory.rx.modelSelected(DataFieldHistory.self).bind { data in
            print(data.fields?.historyId ?? "")
        }.disposed(by: bag)
        
        tableViewHistory.refreshControl?.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] in
            self?.hvm.getAllHistory()
        }).disposed(by: bag)
        
        hvm.getAllHistory()
    }
    
    //MARK: -TESTING
}

extension RentStatusViewController {
//    extension RentStatusViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rowsToDisplay.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RentTableViewCell") as! RentTableViewCell
//        let good = rowsToDisplay[indexPath.section]
//        //        tableView.deselectRow(at: indexPath, animated: true)
//        cell.setGood(good: good)
//        cell.layer.borderWidth = 0.5
//        cell.layer.cornerRadius = 10
//        cell.clipsToBounds = true
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return rowsToDisplay.count
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = LentStatusDetailViewController()
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true, completion: nil)
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacingHeight
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .clear
//        return headerView
//    }
    
    
    struct ViewControllerPreviews: PreviewProvider {
        static var previews: some View {
            UIViewControllerPreview {
                return RentStatusViewController()
            }
            .previewDevice("iPhone 13")
        }
    }
    
}




