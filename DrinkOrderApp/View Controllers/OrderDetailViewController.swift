//
//  OrderDetailViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/18.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = Colors.kebukeDarkBlue
        tableView.isScrollEnabled = true
        return tableView
    }()

    // Show the product image at the top.
    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = Colors.kebukeLightBlue
        scrollView.showsHorizontalScrollIndicator = true
        return scrollView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI () {
        
        setNavigationView()
        addConstraints()
        
        self.view.backgroundColor = Colors.white
    }
    

    func setNavigationView () {
        self.navigationItem.title = "飲料名稱"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeLightBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func addConstraints () {
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            productImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
    }
}

extension OrderDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

#Preview {
    UINavigationController(rootViewController: OrderDetailViewController())
}
