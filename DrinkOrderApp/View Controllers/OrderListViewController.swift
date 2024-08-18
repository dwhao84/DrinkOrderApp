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
    var orderResponse: [CustomerOrder] = []

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
//        print(orders.id)
    }
    
    // MARK: - view Will Appear
    // MARK: viewWillAppear to Make sure the tabBar is showing.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Setup UI
    func setupUI () {
        updateCheckoutViewText()
        self.view.backgroundColor = Colors.kebukeDarkBlue
        addConstraints()
        addDelegateAndDatasource()
        setupNavigationItem()
        setupTableView()
        addTargets ()
        fetchOrdersData()
    }
    
    func updateCheckoutViewText () {
        checkoutView.cupCountLabel.text = "杯數: \(0)"
        checkoutView.totalPriceLabel.text = "$ \(0)"
        print("DEBUG PRINT: Update the cup count & total price as zero")
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
    
    func updateTotalLabels() {
        let totals = calculateTotalQtyAndPrice(from: orders)
        checkoutView.totalPriceLabel.text = "$ \(totals.totalPrice)"
        checkoutView.cupCountLabel.text = "杯數: \(totals.totalQty)"
    }
    
    func calculateTotalQtyAndPrice(from orders: [CustomerOrderFields]) -> (totalQty: Int, totalPrice: Int) {
        var totalQty = 0
        var totalPrice = 0
        
        for order in orders {
            if let qtyString = order.qty, let qty = Int(qtyString),
               let priceString = order.price?.replacingOccurrences(of: "$", with: ""), let price = Int(priceString) {
                totalQty += qty
                totalPrice += (price / qty * qty)
            }
        }
        return (totalQty, totalPrice)
    }

    // MARK: - Fetch Orders Data
    func fetchOrdersData() {
        NetworkManager.shared.getAirtableData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let orders):
                DispatchQueue.main.async {
                    // 更新 orderResponse 数组，保持完整的 CustomerOrder 对象
                    self.orderResponse = orders
                    
                    // 仅提取 fields 部分，更新 orders 数组
                    self.orders = orders.map { $0.fields }
                    
                    print("DEBUG: Number of orders fetched: \(self.orders.count)") // 调试：打印订单数量
                    
                    // 刷新表格视图
                    self.tableView.reloadData()
                    
                    // 更新总计标签（如有必要）
                    self.updateTotalLabels()
                }
            case .failure(let error):
                print("Failed to fetch orders: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    // 处理错误情况，例如显示警告视图或刷新UI
                }
            }
        }
    }


    
    // MARK: - DELETE Order data:
    func deleteOrder(orderId: String, at indexPath: IndexPath, completionHandler: @escaping (Bool) -> Void) {
        NetworkManager.shared.deleteOrdersData(orderId: orderId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success():
                // 从数据源中移除订单
                DispatchQueue.main.async {
                    self.orders.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    completionHandler(true)  // 通知 swipe action 完成
                }
            case .failure(let error):
                print("Failed to delete order: \(error.localizedDescription)")
                // 处理错误，可能向用户展示一个警告框
                completionHandler(false)
            }
        }
    }
    
    func fetchPathDrinksData(recordID: String, updatedFields: [String: Any]) {
        NetworkManager.shared.updateOrder(recordID: recordID, updatedFields: updatedFields) { result in
            switch result {
            case .success():
                print("Successfully updated the record with ID: \(recordID)")
                // 你可以在这里刷新数据或更新UI
                self.fetchOrdersData()  // 如果需要，重新获取最新数据并刷新UI
            case .failure(let error):
                print("Failed to update the record: \(error.localizedDescription)")
                // 处理错误，例如显示错误提示
            }
        }
    }

    
    // MARK: - Add Actions:
    @objc func refresh(_ sender: Any) {
        refreshControl.endRefreshing()
        
        // Cancel the selected indexPath for item, and selected tableView.
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
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
        if let urlString = orderData.url, let url = URL(string: urlString) {
            cell.drinksImageView.kf.setImage(with: url)
        }
        
        cell.selectionStyle = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }

            // 获取对应的 CustomerOrder 对象
            let orderToDelete = self.orderResponse[indexPath.row]
            let id = orderToDelete.id  // Get the id from orderResponse.

            print("Order ID: \(id)")

            // 调用删除方法
            self.deleteOrder(orderId: id, at: indexPath) { success in
                if success {
                    // if delete success, then update UI.
                    print("Delete success")
                    completionHandler(true)
                } else {
                    // if delete failed, then update UI.
                    print("Delete failed")
                    completionHandler(false)
                }
            }
        }
        print("DEBUG PRINT: Swipe action, delete the \(indexPath.row) of item.")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}

#Preview {
    UINavigationController(rootViewController: OrderListViewController())
}
