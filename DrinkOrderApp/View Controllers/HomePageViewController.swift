//
//  HomePageViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class HomePageViewController: UIViewController {
    
    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
//        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeLightBlue
        setupNavigationView()
    }
    
    func setupNavigationView () {
        self.navigationItem.titleView = productImageView
    }
}

#Preview {
    UINavigationController(rootViewController: HomePageViewController())
}
