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
    private let apiKey: String = "patxAQx4KLgwEsh8O.28a883dd0c29a3920aee1cc069fc876738b14186ec8ec2dd07cc762b70497e0c"
    private let baseUrl: String = "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke"
    
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

    // MARK: - Result type:
    enum Result<drinks, Error: Swift.Error>  {
        case success(drinks)
        case failure(Error)
    }
    
    enum NetworkError: Swift.Error {
        case invalidURL
        case requestFailed
        case unexpectedStatusCode
        case noDataReceived
        case decodeError
    }
        
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Into the HomePageVC")
        setupUI()
        
        fetchDrinksData(url: baseUrl) {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let drinks):
                self.drinks = drinks.records
                print("DEBUG PRINT: drinks data \(drinks.self.records.count)")
                self.productTableView.reloadData()
            case .failure(let error):
                print("DEBUG PRINT: Error fetching drinks data: \(error)")
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
    
    func fetchDrinksData(url: String, completion: @escaping( Result<Kebuke, NetworkError>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            print("Unable to fetch url")
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {  data, response, error in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                // TODO: - print out response
                print("\(String(describing: response))")
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let drinksData = try decoder.decode(Kebuke.self, from: data)
                completion(.success(drinksData))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
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
}

// MARK: - Extension:
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        cell.drinksTitleLabel.text       = drinksData.fields.drinksName
        cell.drinksDescriptionLabel.text = drinksData.fields.drinksDescription
        cell.drinksPriceLabel.text       = "中 : \(drinksData.fields.mediumPrice) / 大 : \(drinksData.fields.largePrice)"
        
//         Set up tableView cell when selected will show inside of the corner shape.
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

        orderDetailVC.drinksName        = drinks.fields.drinksName
        orderDetailVC.drinksDescription = drinks.fields.drinksDescription
        orderDetailVC.drinksImageURL    = drinks.fields.drinksImages?.last?.url
        self.navigationController?.pushViewController(orderDetailVC, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: HomePageViewController())
}
