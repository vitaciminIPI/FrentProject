//
//  TabBarViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 9/21/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    //MARK: - CONS & VAR
    var user: UserModels?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        let vc1 = HomeViewController()
        let vc2 = RequestViewController()
        let vc3 = ProfileViewController()
        
        tabBar.backgroundColor = .white
        
//        vc1.title = "Home"
//        vc2.title = "Request"
//        vc3.title = "Profile"
        
//        vc1.navigationItem.largeTitleDisplayMode = .always
//        vc2.navigationItem.largeTitleDisplayMode = .always
//        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "safari"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Request", image: UIImage(systemName: "doc"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
        
//        nav1.navigationBar.prefersLargeTitles = true
//        nav2.navigationBar.prefersLargeTitles = true
//        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    


}

