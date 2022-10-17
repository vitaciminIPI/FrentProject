//
//  OnboardingViewController.swift
//  FrentMC
//
//  Created by Ismawan Maulidza on 10/10/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionViewCell!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var programmedScroll: Bool = false
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            currentPage == 0 ? hidePreviousButton() : showPreviousButton()
        }
    }
    
    private let slides = [
        OnboardingSlide(titles: "Pinjamkan Barang", descriptions: "Punya buku atau alat kuliah tak terpakai? Pinjamkan untuk mendapat uang tambahan!", images: "0"),
        OnboardingSlide(titles: "Sewa Barang", descriptions: "Membutuhkan sesuatu untuk belajar? Sewa dari mahasiswa lain sekarang!", images: "1"),
        OnboardingSlide(titles: "Temukan Teman", descriptions: "Bertemu di kampus atau lewat kurir daring. Temukan teman baru di kampus!", images: "2")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()
        collectionView.contentInsetAdjustmentBehavior = .never
        pageControl.numberOfPages = slides.count
        currentPage == 0 ? hidePreviousButton() : showPreviousButton()

    }
    
    func initList(){
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .blue
        startButton.backgroundColor = .blue
        
        nextButton.setTitleColor(.blue, for: .normal)
        skipButton.setTitleColor(.systemGray, for: .normal)
        previousButton.setTitleColor(.blue, for: .normal)
        
        startButton.layer.cornerRadius = 10
    }
        
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        if currentPage != 0 {
            currentPage -= 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            // disable scrollViewDidScroll code execution
            self.programmedScroll = true
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            //hide onboarding
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            // disable scrollViewDidScroll code execution
            self.programmedScroll = true
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        currentPage = 2
        let indexPath = IndexPath(item: currentPage, section: 0)
        // disable scrollViewDidScroll code execution
        self.programmedScroll = true
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    //MARK: - User Interface Layout Methods
    
    func showPreviousButton() {
        hideShowButton()
    }
    
    func hidePreviousButton() {
        hideShowButton()
    }
    
    func hideShowButton() {
        if currentPage == 0 {
            startButton.isHidden = true
            nextButton.isHidden = false
            previousButton.isHidden = true
            skipButton.isHidden = false
        } else if currentPage == 1 {
            startButton.isHidden = true
            nextButton.isHidden = false
            previousButton.isHidden = false
            skipButton.isHidden = false
        } else if currentPage == 2 {
            startButton.isHidden = false
            nextButton.isHidden = true
            previousButton.isHidden = true
            skipButton.isHidden = true
        }
    }


}

//MARK: - CollectionView Delegate Methods

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCollectionViewCell
            
        cell.imageView.image = UIImage(named: "\(slides[indexPath.row].images)")
        cell.mainLabel.text = slides[indexPath.row].titles
        cell.subLabel.text = slides[indexPath.row].descriptions
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // don't execute this if WE called scrollToItem
        if !programmedScroll {
            let visibleRectangle = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRectangle.midX, y: visibleRectangle.midY)
            currentPage = collectionView.indexPathForItem(at: visiblePoint)?.row ?? 0
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // re-enable execution of scrollViewDidScroll code
        programmedScroll = false
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()

        let indexPath = IndexPath(item: self.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

