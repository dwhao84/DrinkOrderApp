//
//  HomePageViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit
import Kingfisher

class HomePageViewController: UIViewController {

    static let shared: String = "HomePageViewController"
    var userName: String?
    
    var drinks: [Record] = []
//    var drinksOfSelectedCategory = [Record]()
    
    // MARK: - UI set up:
    let kebukeLogoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let productTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.allowsSelection = true
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = Colors.kebukeLightBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    let refreshControl: UIRefreshControl = {
        // Initialize with a string and separately declared attribute(s)
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.tintColor = Colors.kebukeBrown
        return refreshControl
    } ()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Into the HomePageVC")
        
        setupUI()
        fetchDrinksData ()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func fetchDrinksData() {
        // Call Network Manager to fetch data
        NetworkManager.shared.getOrdersData { result in
            switch result {
            case .success(let drinksData):
                // Using DispatchQueue.main.async to fetch data.
                DispatchQueue.main.async {
                    self.drinks = drinksData.records
                }
            case .failure(_):
                print("Unable to get data")
            }
        }
    }

    
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeLightBlue
        setupNavigationItem()
        addTargets()
        addDelegateAndDataSource()
        addConstraints()
    }
        
    // set up titleView
    func setupNavigationItem () {
        kebukeLogoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.navigationItem.titleView = kebukeLogoImageView
        self.navigationItem.titleView?.backgroundColor = Colors.kebukeDarkBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.list, style: .plain, target: self, action: #selector(listBarBtnTapped))
        
        // set up appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeDarkBlue
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    // Add tableview delegate & dataSource
    func addDelegateAndDataSource () {
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(DrinkTableViewCell.self, forCellReuseIdentifier: DrinkTableViewCell.identifier)
        productTableView.rowHeight = 150
        productTableView.refreshControl = refreshControl
    }
    
    // Add Constraints
    func addConstraints () {
        self.view.addSubview(productTableView)
        
        // MARK:  Constraint TableView
        NSLayoutConstraint.activate([
            productTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    // Add targets
    func addTargets () {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc func refresh(_ sender: Any) {
        refreshControl.endRefreshing()
        // TODO: -
        productTableView.reloadData()
        print("DEBUG PRINT: End Refreshing")
    }
    
    @objc func listBarBtnTapped () {
        let settingVC = SettingTableViewController()
        settingVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        // 設置tag 以便後續查找 以及 移除
        activityIndicator.tag = 1
        activityIndicator.center = self.view.center
        activityIndicator.color = Colors.kebukeBrown
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        if let activityIndicator = self.view.viewWithTag(1) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}

// MARK: - Extension:
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG PRINT: 資料為\(drinks.count)筆")
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkTableViewCell.identifier, for: indexPath) as! DrinkTableViewCell
//        
        cell.backgroundColor = Colors.kebukeLightBlue
        cell.selectionStyle  = .gray
        // Define the drinksData from drinks(an array).
        let drinksData = drinks[indexPath.row]
        
        // Using Kingfisher to set the image from URL
        if let imageUrlString = drinksData.fields.drinksImages?.last?.url, let url = URL(string: imageUrlString) {
            cell.drinksImageView.kf.setImage(with: url)
        } else {
            cell.drinksImageView.image   = Images.banner02 // Set a default image if URL is not available
        }
        
        cell.drinksTitleLabel.text       = drinksData.fields.drinkName
        cell.drinksDescriptionLabel.text = drinksData.fields.drinksDescription
        cell.drinksPriceLabel.text       = "中 : \(drinksData.fields.mediumPrice) / 大 : \(drinksData.fields.largePrice)"
        
        // Set up tableView cell when selected will show inside of the corner shape.
        let backgroundView: UIView        = UIView()
        backgroundView.backgroundColor    = Colors.kebukeDarkBlueWithAlpha
        backgroundView.layer.cornerRadius = 25
        backgroundView.clipsToBounds      = true
        cell.selectedBackgroundView       = backgroundView
        return cell
    }
    
    // MARK: - UITableViewDelegate:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG PRINT:\(indexPath.row)")
        
        let drinks = drinks[indexPath.row]
        let orderDetailVC = OrderDetailViewController()
        orderDetailVC.modalPresentationStyle = .overFullScreen

        orderDetailVC.drinksName        = drinks.fields.drinkName
        orderDetailVC.drinksDescription = drinks.fields.drinksDescription
        orderDetailVC.drinksImageURL    = drinks.fields.drinksImages?.last?.url
        orderDetailVC.userName = userName
        self.navigationController?.pushViewController(orderDetailVC, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: HomePageViewController())
}
