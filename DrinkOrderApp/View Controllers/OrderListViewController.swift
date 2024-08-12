//
//  OrderListViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit
import Kingfisher

class OrderListViewController: UIViewController {
    
    static let shared: String = "OrderListViewController"
    private let baseUrl: String = "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke"
    private let apiKey: String = "Bearer patxAQx4KLgwEsh8O.28a883dd0c29a3920aee1cc069fc876738b14186ec8ec2dd07cc762b70497e0c"
    
    var orders: [CustomerOrderFields] = []
    
    // MARK: - UI set up:
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = Colors.white
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()

    private let productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let refreshControl: UIRefreshControl = {
        // Initialize with a string and separately declared attribute(s)
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.tintColor = Colors.kebukeBrown
        return refreshControl
    } ()
    
    private var checkoutView: CheckoutView = {
        let checkoutView: CheckoutView = CheckoutView()
        checkoutView.translatesAutoresizingMaskIntoConstraints = false
        return checkoutView
    } ()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.color = Colors.kebukeBrown
        return spinner
    } ()
     
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Go into the OrderListVC")
        
        setupUI()
    }
    
    // MARK: - view Will Appear
    // MARK: viewWillAppear to Make sure the tabBar is showing.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Setup UI
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeDarkBlue
        addConstraints()
        addDelegateAndDatasource()
        setupNavigationItem()
        setupTableView()
        addTargets ()
        fetchOrdersData()
    }
    
    // MARK: Add Targets
    func addTargets () {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    // MARK: setup TableView
    func setupTableView () {
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: OrderListTableViewCell.identifier)
        tableView.rowHeight = 170
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = Colors.white
        tableView.tableFooterView = spinner
    }
    
    // MARK: add Delegate & Datasource
    func addDelegateAndDatasource () {
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: add Constraints
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
    
    // MARK: Set up navigation item
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
    
    // MARK: - GET Order data:
    func fetchOrdersData() {
        NetworkManager.shared.getAirtableData { result in
            switch result {
            case .success(let order):
                self.orders = order
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch orders: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - DELETE Order data:
    func fetchDeleteDrinksData () {
        
    }
    
    // MARK: Show Alert Controller:
    func showErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertController(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Add Actions:
    @objc func refresh(_ sender: Any) {
        refreshControl.endRefreshing()
        tableView.reloadData()
        fetchOrdersData()
        print("DEBUG PRINT: End Refreshing")
    }
}

// MARK: - Extension:
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG PRINT: \(orders.count)")
        return orders.count
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderListTableViewCell.identifier, for: indexPath) as! OrderListTableViewCell
        
        let orderData = orders[indexPath.row]
        cell.drinksTitleLabel.text    = orderData.drinkName
        cell.userNameLabel.text       = orderData.userName
        cell.toppingContentLabel.text = orderData.topping
        cell.iceLevelLabel.text       = orderData.iceLevel
        cell.drinksPriceLabel.text    = orderData.price
        cell.qtyLabel.text            = "數量: \(orderData.qty ?? "")"
    
        cell.selectionStyle = .gray
        return cell
    }
    
    // MARK: trailing Swipe Actions Configuration For Row At
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        showAlertController("🚨 資料刪除", "Ok")
        
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除")  { _,_,_ in
            print("DEBUG PRINT: 刪除")
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

#Preview {
    UINavigationController(rootViewController: OrderListViewController())
}
