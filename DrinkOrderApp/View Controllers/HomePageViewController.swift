//
//  HomePageViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit
import Kingfisher

class HomePageViewController: UIViewController {

    let bannerImageViewArray: [UIImage] = [
        Images.banner01,
        Images.banner02,
        Images.banner03,
        Images.banner04,
        Images.banner05,
        Images.banner06,
        Images.banner07,
        Images.banner08,
    ]
    
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
        imageView.image = Images.banner01
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
        pageControl.direction = .leftToRight
        pageControl.currentPageIndicatorTintColor = Colors.kebukeBrown
        pageControl.backgroundStyle = .minimal
        pageControl.numberOfPages = 8
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
        tableView.backgroundColor = Colors.kebukeLightBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    var refreshControl: UIRefreshControl = {
        // Initialize with a string and separately declared attribute(s)
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.tintColor = Colors.kebukeBrown
        return refreshControl
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
        
        print("Into the HomePageVC")
        
        setupUI()
        
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeLightBlue
        setupNavigationItem()
        setupTableView()
        addDelegateAndDataSource()
        addConstraints()
        fetchDrinksData()
        
        addTargets()
    }
    
    
    func setupTableView () {
        drinksTableView.register(DrinkTableViewCell.self, forCellReuseIdentifier: DrinkTableViewCell.identifier)
        drinksTableView.rowHeight = 170
        drinksTableView.refreshControl = refreshControl
    }
    
    func setupNavigationItem () {
        // set up titleView
        productImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.navigationItem.titleView = productImageView
        
        self.navigationItem.titleView?.backgroundColor = Colors.kebukeDarkBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.list, style: .plain, target: self, action: #selector(listBarBtnTapped))
        
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
        
        let widthOfView = view.bounds.width
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            bannerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: widthOfView * 0.56),

            pageControl.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),

            drinksTableView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            drinksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drinksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drinksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func addTargets () {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    @objc func refresh(_ sender: Any) {
        //  your code to reload tableView
        refreshControl.endRefreshing()
        drinksTableView.reloadData()
        print("DEBUG PRINT: End Refreshing")
    }
    
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        bannerImageView.image = bannerImageViewArray[(sender.currentPage) % bannerImageViewArray.count]
        print(sender.currentPage)
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
    
    @objc func listBarBtnTapped () {
        let settingVC = SettingTableViewController()
        settingVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(settingVC, animated: true)
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
        
        cell.backgroundColor = Colors.kebukeLightBlue
        cell.selectionStyle = .gray
        // Define the drinksData from drinks(an array).
        let drinksData = drinks[indexPath.row]
        
        // Using Kingfisher to set the image from URL
        if let imageUrlString = drinksData.fields.drinksImages?.last?.url, let url = URL(string: imageUrlString) {
            cell.drinksImageView.kf.setImage(with: url)
        } else {
            cell.drinksImageView.image = Images.banner02 // Set a default image if URL is not available
        }
        cell.drinksTitleLabel.text       = drinksData.fields.drinksName
        cell.drinksDescriptionLabel.text = drinksData.fields.drinksDescription
        cell.drinksPriceLabel.text       = "中 : \(drinksData.fields.mediumPrice) / 大 : \(drinksData.fields.largePrice)"
        
        // Set up tableView cell when selected will show inside of the corner shape.
        let backgroundView: UIView = UIView()
        backgroundView.backgroundColor = Colors.kebukeDarkBlueWithAlpha
        backgroundView.layer.cornerRadius = 25
        backgroundView.clipsToBounds = true
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    // MARK: - UITableViewDelegate:
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("DEBUG PRINT:\(indexPath.row)")
        
        let drinksName = drinks[indexPath.row].fields.drinksName
        let orderDetailVC = OrderDetailViewController()
        orderDetailVC.modalPresentationStyle = .popover
        print("\(drinksName)")
        self.present(orderDetailVC, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: HomePageViewController())
}
