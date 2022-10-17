//
//  LentStatusDetailViewController.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 13/10/22.
//

import UIKit

class LentStatusDetailViewController: UIViewController {

    //MARK: - LABEL
    
    lazy private var statusDetailTitles: UILabel = {
        let label = ReusableLabel(labelType: .lentStatTitle, labelString: "Status Barang")
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    lazy private var statusTitles: UILabel = {
        let label = ReusableLabel(labelType: .lentStatTitle, labelString: "Ketersediaan")
        return label
    }()
    
    lazy private var renterTitles: UILabel = {
        let label = ReusableLabel(labelType: .lentStatTitle, labelString: "Nama Penyewa")
        return label
    }()
    
    lazy private var rentDurationTitles: UILabel = {
        let label = ReusableLabel(labelType: .lentStatTitle, labelString: "Durasi penyewaan")
        return label
    }()
    
    lazy private var EstimationTitles: UILabel = {
        let label = ReusableLabel(labelType: .lentStatTitle, labelString: "Estimasi tersedia kembali")
        return label
    }()
    
    lazy private var availableStatus: UILabel = {
        let label = ReusableLabel(labelType: .lentStatBody, labelString: "Tersedia")
        return label
    }()
    
    lazy private var unAvailableStatus: UILabel = {
        let label = ReusableLabel(labelType: .lentStatBody, labelString: "Tidak tersedia")
        return label
    }()
    
    lazy private var durationOne: UILabel = {
        let label = ReusableLabel(labelType: .lentStatBody, labelString: "2 Minggu")
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy private var durationTwo: UILabel = {
        let label = ReusableLabel(labelType: .lentStatBody, labelString: "3 Bulan")
        return label
    }()
    
    lazy private var durationThree: UILabel = {
        let label = ReusableLabel(labelType: .lentStatBody, labelString: "6 Bulan")
        return label
    }()
    
    //MARK: - BUTTON
    
    lazy private var changeStatus: UIButton = {
        let btn = ReusableButton(buttonTypes: .next)
        btn.setTitle("Ubah status barang", for: .normal)
        btn.addTarget(self, action: #selector(didTapChangeButton), for: .touchUpInside)
        return btn
    }()
    
    lazy private var availableButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .notChecked)
        btn.tag = 0
        btn.addTarget(self, action: #selector(didTapAvailableButton), for: .touchUpInside)
        return btn
    }()
    
    lazy private var unAvailableButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .notChecked)
        btn.tag = 1
        btn.addTarget(self, action: #selector(didTapUnAvailableButton), for: .touchUpInside)
        return btn
    }()
    
    lazy private var durationOneButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .notChecked)
        btn.tag = 2
        btn.addTarget(self, action: #selector(didTapTwoWeekButton), for: .touchUpInside)
        return btn
    }()
    
    lazy private var durationTwoButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .notChecked)
        btn.tag = 3
        btn.addTarget(self, action: #selector(didTapThreeMonthButton), for: .touchUpInside)
        return btn
    }()
    
    lazy private var durationThreeButton: UIButton = {
        let btn = ReusableButton(buttonTypes: .notChecked)
        btn.tag = 4
        btn.addTarget(self, action: #selector(didTapSixMonthButton), for: .touchUpInside)
        return btn
    }()
    
    lazy private var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(systemName: "xmark")
        let tintedImg = img?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintedImg, for: .normal)
        btn.tintColor = UIColor().getButtonColor()
        btn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: - TEXT FIELD
    lazy private var searchTF: UISearchTextField = {
       let tf = UISearchTextField()
        tf.placeholder = "Ketik nama penyewa"
        return tf
    }()
    
    lazy private var dateTF: UITextField = {
        let tf = ReusableTextField(tfType: .defaults, tfPholder: "Pilih tanggal")
        tf.inputView = datePicker
        return tf
    }()
    
    //MARK: - DATE PICKER
    
    lazy private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.timeZone = TimeZone.current
        picker.preferredDatePickerStyle = .inline
        picker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        return picker
    }()
    
    //MARK: - STACK VIEW
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [statusDetailTitles, closeButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    //MARK: - CONTAINER VIEW
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
        
    // Constants
    let defaultHeight: CGFloat = 650
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupConstraints()
        setupUI()
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setupUI() {
        view.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        
        //MARK: - STATUS SEGMENT
        view.addSubview(statusTitles)
        view.addSubview(availableButton)
        view.addSubview(availableStatus)
        view.addSubview(unAvailableButton)
        view.addSubview(unAvailableStatus)
        statusTitles.anchor(top: stackView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        availableButton.anchor(top: statusTitles.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        availableStatus.anchor(top: statusTitles.bottomAnchor, bottom: nil, leading: availableButton.trailingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 10, bottom: 0, right: 0))
        unAvailableButton.anchor(top: availableButton.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        unAvailableStatus.anchor(top: availableButton.bottomAnchor, bottom: nil, leading: unAvailableButton.trailingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 10, bottom: 0, right: 0))
        
        //MARK: - RENTER SEGMENT
        view.addSubview(renterTitles)
        view.addSubview(searchTF)
        renterTitles.anchor(top: unAvailableButton.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        searchTF.anchor(top: renterTitles.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - RENT DURATION
        view.addSubview(rentDurationTitles)
        view.addSubview(durationOneButton)
        view.addSubview(durationOne)
        view.addSubview(durationTwoButton)
        view.addSubview(durationTwo)
        view.addSubview(durationThreeButton)
        view.addSubview(durationThree)
        rentDurationTitles.anchor(top: searchTF.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        durationOneButton.anchor(top: rentDurationTitles.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        durationOne.anchor(top: rentDurationTitles.bottomAnchor, bottom: nil, leading: durationOneButton.trailingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 10, bottom: 0, right: 0))
        durationTwoButton.anchor(top: durationOneButton.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        durationTwo.anchor(top: durationOneButton.bottomAnchor, bottom: nil, leading: durationTwoButton.trailingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 10, bottom: 0, right: 0))
        durationThreeButton.anchor(top: durationTwoButton.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0))
        durationThree.anchor(top: durationTwoButton.bottomAnchor, bottom: nil, leading: durationThreeButton.trailingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 10, bottom: 0, right: 0))
        
        //MARK: - DURATION SEGMENT
        view.addSubview(EstimationTitles)
        view.addSubview(dateTF)
        EstimationTitles.anchor(top: durationThreeButton.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        dateTF.anchor(top: EstimationTitles.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        
        //MARK: - CHANGE STATUS BUTTON
        view.addSubview(changeStatus)
        changeStatus.anchor(top: dateTF.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 50))
    }
    
    private func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    private func animateShowDimmedView() {
            dimmedView.alpha = 0
            UIView.animate(withDuration: 0.4) {
                self.dimmedView.alpha = self.maxDimmedAlpha
            }
        }
    
    private func animatePresentContainer() {
            // update bottom constraint in animation block
            UIView.animate(withDuration: 0.3) {
                self.containerViewBottomConstraint?.constant = 0
                // call this to trigger refresh constraint
                self.view.layoutIfNeeded()
            }
        }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    private func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false, completion: nil)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func didTapAvailableButton() {
        radioChangeButton(isChecked: true, sender: availableButton)
        radioChangeButton(isChecked: false, sender: unAvailableButton)
        print(availableButton.tag)
        print(unAvailableButton.tag)
        print(durationOneButton.tag)
        print(durationTwoButton.tag)
        print(durationThreeButton.tag)
        
    }
    
    @objc private func didTapUnAvailableButton() {
        radioChangeButton(isChecked: false, sender: availableButton)
        radioChangeButton(isChecked: true, sender: unAvailableButton)
    }
    
    @objc private func didTapTwoWeekButton() {
        radioChangeButton(isChecked: true, sender: durationOneButton)
        radioChangeButton(isChecked: false, sender: durationTwoButton)
        radioChangeButton(isChecked: false, sender: durationThreeButton)
    }
    
    @objc private func didTapThreeMonthButton() {
        radioChangeButton(isChecked: false, sender: durationOneButton)
        radioChangeButton(isChecked: true, sender: durationTwoButton)
        radioChangeButton(isChecked: false, sender: durationThreeButton)
    }
    
    @objc private func didTapSixMonthButton() {
        radioChangeButton(isChecked: false, sender: durationOneButton)
        radioChangeButton(isChecked: false, sender: durationTwoButton)
        radioChangeButton(isChecked: true, sender: durationThreeButton)
    }
    
    private func radioChangeButton(isChecked: Bool, sender: UIButton) {
        if isChecked {
            let oriImg = UIImage(systemName: "circle.circle.fill")
            let tintedImg = oriImg?.withRenderingMode(.alwaysTemplate)
            sender.setImage(tintedImg, for: .normal)
            sender.tintColor = UIColor().getButtonColor()
        }
        else {
            let oriImg = UIImage(systemName: "circle")
            let tintedImg = oriImg?.withRenderingMode(.alwaysTemplate)
            sender.setImage(tintedImg, for: .normal)
            sender.tintColor = UIColor().getButtonColor()
        }
        
    }
    
    @objc private func didTapChangeButton() {
        print("changed")
    }
    
    @objc private func handleClose() {
        self.dismiss(animated: true)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateTF.text = dateFormatter.string(from: sender.date)
     }

}
