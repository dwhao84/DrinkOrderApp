//
//  HomePageViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class HomePageViewController: UIViewController {
 
    let bannerNameArray: [String] = [ "00", "01_紅玉熟成", "02_芒波&麥雪", "03_茉玉春蘋"]
    
    // MARK: - UI set up:
    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var searchController: UISearchController = {
        let searchController: UISearchController = UISearchController()
        searchController.searchBar.text = ""
        searchController.isActive = true
        return searchController
    } ()
    
    var bannerImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.banner_03
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    
    var pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
        pageControl.direction = .leftToRight
        pageControl.currentPageIndicatorTintColor = Colors.kebukeBrown
        
        let timeProgress = UIPageControlTimerProgress(preferredDuration: 3.5)
        pageControl.progress = timeProgress
        timeProgress.resetsToInitialPageAfterEnd = true
        timeProgress.resumeTimer()
        timeProgress.currentProgress = 1
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    } ()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeLightBlue
        setupNavigationItem()
        addConstrants()
    }
    
    func setupNavigationItem () {
        // set up titleView
        self.navigationItem.titleView = productImageView
        self.navigationItem.titleView?.backgroundColor = Colors.kebukeDarkBlue
        
        // set up appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeDarkBlue
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
    
    func addConstrants () {
        view.addSubview(bannerImageView)
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.3)
        ])
    }
}

// MARK: - Extension:


#Preview {
    UINavigationController(rootViewController: HomePageViewController())
}
