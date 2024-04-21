//
//  OrderListViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class OrderListViewController: UIViewController {

    // MARK: - UI set up:
    var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = Colors.white
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    var checkoutView: UIView = {
        let view: UIView  = UIView()
        view.backgroundColor = Colors.kebukeLightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI () {
        addConstraints()
        addDelegateAndDatasource()
        setupNavigationItem()
        configureTableView()
    }
    
    func configureTableView () {
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: OrderListTableViewCell.identifier)
        tableView.rowHeight = 150
        tableView.isPrefetchingEnabled = true
    }
    
    func addDelegateAndDatasource () {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func addConstraints () {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationItem () {
        // set up titleView
        self.navigationItem.titleView = productImageView
        self.navigationItem.titleView?.backgroundColor = Colors.kebukeDarkBlue
        self.navigationController?.navigationBar.backgroundColor = Colors.kebukeDarkBlue
        self.navigationController?.navigationBar.barTintColor = Colors.kebukeDarkBlue
        
        // set up appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeDarkBlue
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
}

// MARK: - Extension:
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderListTableViewCell.identifier, for: indexPath) as! OrderListTableViewCell
        cell.drinksTitleLabel.text = "熟成紅茶"
        cell.drinksDescriptionLabel.text = "帶有濃穩果香的經典紅茶"
        cell.drinksPriceLabel.text = "中: / 大:"
        cell.drinksImageView.image = Images.banner_01
        return cell
    }
    
    
}


#Preview {
    UINavigationController(rootViewController: OrderListViewController())
}
