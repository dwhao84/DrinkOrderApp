//
//  HomePageViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class HomePageViewController: UIViewController {
 
    static let shared: String = "HomePageViewController"
    private let apiKey: String = ""
    
    var drinks = [Record] ()
    var drinksOfSelect = [Record]()
    
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
    
    var drinksTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.rowHeight = 100
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeLightBlue
        
        setupNavigationItem()
        
        addDelegateAndDataSource()
        configureDrinksTableView()
        
        addConstraints()

    }
    
    func setupNavigationItem () {
        // Set up titleView
        self.navigationItem.titleView = productImageView
        self.navigationItem.titleView?.backgroundColor = Colors.kebukeDarkBlue
        
        // Set up appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeDarkBlue
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    func configureDrinksTableView () {
        drinksTableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: OrderListTableViewCell.identifier)
        
    }
    
    func addDelegateAndDataSource () {
        drinksTableView.delegate = self
        drinksTableView.dataSource = self
    }
    
    func addConstraints () {
        view.addSubview(bannerImageView)
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.3)
        ])
    }
    
    func fetchDrinksData () {
        let url = URL(string: "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke")!
        var request = URLRequest(url: url)
        
        // 搞清出這段程式的意思
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        // Get the data by using Decoder.
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let decoder = JSONDecoder()
                let drink = try decoder.decode(Kebuke.self, from: data)
                self.drinks = drink.records
                
                DispatchQueue.main.async {
                    
                    // Add the drinksTableView into the main thread.
                    self.drinksTableView.reloadData()
                }
            } catch {
                print("DEBUG PRINT: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// MARK: - Extension:
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(drinksOfSelect.count)")
        return drinksOfSelect.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderListTableViewCell.identifier, for: indexPath)
        let drinks = drinksOfSelect[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("DEBUG PRINT: didSelectRowAt: \(indexPath.row)")
    }
}


#Preview {
    UINavigationController(rootViewController: HomePageViewController())
}
