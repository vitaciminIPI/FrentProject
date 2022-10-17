//
//  OnboardViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/10/22.
//

import UIKit

class OnboardViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for image in 0...2 {
            let imageToDisplay = UIImage(named: "\(image).png")
            let imageView = UIImageView(image: imageToDisplay)
            
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate, y: view.frame.height, width: 100, height: 100)
        }
    }

}
