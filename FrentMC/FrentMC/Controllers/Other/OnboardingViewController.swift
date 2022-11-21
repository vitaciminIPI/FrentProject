//
//  OnboardingViewController.swift
//  TestingOnboarding
//
//  Created by Ismawan Maulidza on 11/10/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    //MARK: - FRENT LOGO
    lazy var logoImage: UIView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        view.addSubview(logo)
        return logo
    }()
    
    //MARK: -SCROLLVIEW 1,2,3
    lazy var view0: UIView = {
        let img1 = UIImageView()
        img1.image = UIImage(named: "pinjam")
        view.addSubview(img1)
        return img1
    }()
    
    lazy var view1: UIView = {
        let img2 = UIImageView()
        img2.image = UIImage(named: "sewa")
        view.addSubview(img2)
        return img2
    }()
    
    lazy var view2: UIView = {
        let img3 = UIImageView()
        img3.image = UIImage(named: "temukan")
        view.addSubview(img3)
        return img3
    }()
    
    lazy var views = [view0, view1, view2]
    
    //MARK: - SCROLLVIEW
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: 542)
        
        for i in 0..<views.count {
            scrollView.addSubview(views[i])
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i) + 30, y: 30, width: 326, height: 542)
        }
        scrollView.delegate = self
        
        return scrollView
    }()
    //MARK: - PAGE CONTROL
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
        pageControl.tintColor = .blue
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender: )), for: .touchUpInside)
        return pageControl
    }()
    
    @objc func pageControlTapHandler(sender: UIPageControl){
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
    //MARK: - BUTTON
    lazy private var startButton : UIButton = {
        var button = ReusableButton(buttonTypes: .helpBtn)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        button.setTitle("Mulai Sekarang", for: .normal)
        return button
    }()
    
//MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.edgeTo(view: view)
        view.backgroundColor = .white
        view.addSubview(pageControl)
        view.addSubview(pageControl)
        view.addSubview(startButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipButtonTapped))
        setupui()
    }
//MARK: - CONSTRAINTS
    func setupui(){
        
        logoImage.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 50, left: 10, bottom: 0, right: 300), size: .init(width: 0, height: 60))
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 280).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        startButton.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor ,padding: .init(top: 0, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 0))
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
    }
//MARK: - OBJC FUNC
    
    @objc func didTapStartButton(){
        print("gas")
        self.navigationController?.pushViewController(LoginWithAppleIDViewController(), animated: true)
    }
    
    @objc func skipButtonTapped(){
        print("go")
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
    }


}

//MARK: - SCROLLVIEW DELEGATE

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}


//MARK: - EXTENSION SCROLL VIEW
public extension UIScrollView {
    func edgeTo(view: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


extension UIScrollView {
//    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool?
    func scrollTo(horizontalPage: Int? = 0, animated: Bool? = true){
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
//        frame.origin.x = frame.size.width
//        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
//        self.scrollRectToVisible(frame, animated: animated ?? true)
        
    }
}


