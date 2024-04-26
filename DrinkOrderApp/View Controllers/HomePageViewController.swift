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
    let apiKey: String = "patxAQx4KLgwEsh8O.28a883dd0c29a3920aee1cc069fc876738b14186ec8ec2dd07cc762b70497e0c"
    
    var drinks = [Record] ()
    var drinksOfselectedCategory = [Record]()
    
    // MARK: - UI set up:
    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        pageControl.currentPageIndicatorTintColor = Colors.white
        pageControl.tintColor = Colors.kebukeBrown
        pageControl.backgroundStyle = .prominent
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        
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
        tableView.allowsSelection = true
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.white
        setupNavigationItem()
        setupTableView()
        addDelegateAndDataSource()
        addConstraints()
        fetchDrinksData()
    }
    
    func setupTableView () {
        drinksTableView.register(DrinkTableViewCell.self, forCellReuseIdentifier: DrinkTableViewCell.identifier)
        drinksTableView.rowHeight = 170
        drinksTableView.allowsSelection = true
    }
    
    func setupNavigationItem () {
        // set up titleView
        self.navigationItem.titleView = productImageView
        self.navigationItem.titleView?.backgroundColor = Colors.kebukeDarkBlue
        
        // set up appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeDarkBlue
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    func addDelegateAndDataSource () {
        drinksTableView.delegate = self
        drinksTableView.dataSource = self
        scrollView.delegate = self
    }
    
    func addConstraints () {
        view.addSubview(scrollView)
        scrollView.addSubview(bannerImageView)
        scrollView.addSubview(pageControl)
        scrollView.addSubview(drinksTableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            bannerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: view.bounds.height / 5),

            pageControl.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 70),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),

            drinksTableView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            drinksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drinksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drinksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func fetchDrinksData() {
        guard let url = URL(string: "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke") else {
            print("DEBUG PRINT: Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("DEBUG PRINT: Request error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("DEBUG PRINT: No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let kebuke = try decoder.decode(Kebuke.self, from: data)
                self.drinks = kebuke.records
                print("DEBUG PRINT: Drinks loaded successfully with \(self.drinks.count) records.")

                DispatchQueue.main.async {
                    self.drinksTableView.reloadData()  // Ensure UI updates happen on the main thread
                }
            } catch {
                print("Decode error: \(error.localizedDescription)")
                if let rawJSONString = String(data: data, encoding: .utf8) {
                    print("DEBUG PRINT: Received JSON - \(rawJSONString)")
                }
            }
        }.resume()
    }
}

// MARK: - Extension:
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    // MARK: - UITableViewDataSource:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG PRINT: 資料為\(drinks.count)筆")
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkTableViewCell.identifier, for: indexPath) as! DrinkTableViewCell
        
        // Define the drinksData from drinks(an array).
        let drinksData = drinks[indexPath.row]
        
        // Using Kingfisher to set the image from URL
        if let imageUrlString = drinksData.fields.drinksImages?.last?.url, let url = URL(string: imageUrlString) {
            cell.drinksImageView.kf.setImage(with: url)
        } else {
            cell.drinksImageView.image = Images.banner_02 // Set a default image if URL is not available
        }
        cell.drinksTitleLabel.text       = drinksData.fields.drinksName
        cell.drinksDescriptionLabel.text = drinksData.fields.drinksDescription
        cell.drinksPriceLabel.text       = "中杯:\(drinksData.fields.mediumPrice) / 大杯: \(drinksData.fields.largePrice)"
        
        // Set up tableView cell when selected will show inside of the corner shape.
        let backgroundView: UIView = UIView()
        backgroundView.backgroundColor = Colors.systemGray6
        backgroundView.layer.cornerRadius = 15
        backgroundView.clipsToBounds = true
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    // MARK: - UITableViewDelegate:
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("DEBUG PRINT:\(indexPath.row)")
        let orderDetailVC = OrderDetailViewController()
        orderDetailVC.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(orderDetailVC, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: HomePageViewController())
}
