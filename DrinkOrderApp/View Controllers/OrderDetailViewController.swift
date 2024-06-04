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
        imageView.image = Images.banner03
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
        view.addSubview(productImageView)
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
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
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
