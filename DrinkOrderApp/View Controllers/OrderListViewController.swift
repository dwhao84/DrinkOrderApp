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
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()

    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var refreshControl: UIRefreshControl = {
        // Initialize with a string and separately declared attribute(s)
        let attribute = [ NSAttributedString.Key.foregroundColor: Colors.kebukeBrown ]
        let attrString = NSAttributedString(string: "Refresh Data.", attributes: attribute)
        
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.tintColor = Colors.kebukeBrown
        refreshControl.attributedTitle = attrString
        return refreshControl
    } ()
    
    var checkoutView: CheckoutView = {
        let checkoutView: CheckoutView = CheckoutView()
        checkoutView.translatesAutoresizingMaskIntoConstraints = false
        return checkoutView
    } ()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Go into the OrderListVC")
        
        setupUI()
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeDarkBlue
        addConstraints()
        addDelegateAndDatasource()
        setupNavigationItem()
        setupTableView()
        addTargets ()
    }
    
    func addTargets () {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc func refresh(_ sender: Any) {
        refreshControl.endRefreshing()
        tableView.reloadData()
        print("DEBUG PRINT: End Refreshing")
    }
    
    func setupTableView () {
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: OrderListTableViewCell.identifier)
        tableView.rowHeight = 170
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = Colors.kebukeLightBlue
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
        
        view.addSubview(checkoutView)
        NSLayoutConstraint.activate([
            checkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            checkoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            checkoutView.heightAnchor.constraint(equalToConstant: 50)
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
        cell.drinksPriceLabel.text = "中: 40 / 大: 45"
        cell.drinksImageView.image = Images.banner01
        cell.selectionStyle = .gray
        
        // Set up tableView cell when selected will show inside of the corner shape.
        let backgroundView: UIView = UIView()
        backgroundView.backgroundColor = Colors.kebukeDarkBlueWithAlpha
        backgroundView.layer.cornerRadius = 18
        backgroundView.clipsToBounds = true
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    
}


#Preview {
    UINavigationController(rootViewController: OrderListViewController())
}
