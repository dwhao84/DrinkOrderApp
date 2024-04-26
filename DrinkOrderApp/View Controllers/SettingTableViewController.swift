//
//  SettingTableViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class SettingTableViewController: UIViewController {
    
    var settings: [SettingData] = []

    // MARK: - UI set up:
    var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = Colors.white
        tableView.rowHeight = 100
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        settings = fetchSettingData()
    }
    
    func fetchSettingData () -> [SettingData] {
        // First group -> Contact Information.
        let telephoneNumber = SettingData(serviceName: "店家電話", serviceImage: Images.phone)
        let location        = SettingData(serviceName: "店家地址",         serviceImage: Images.map)
        let email           = SettingData(serviceName: "店家信箱",           serviceImage: Images.mail)
        
        // Second group -> Company Information.
        let declaration     = SettingData(serviceName: "免責聲明",      serviceImage: Images.declaration)
        let inspectReport   = SettingData(serviceName: "食品檢查報告",  serviceImage: Images.report)
        let privacy         = SettingData(serviceName: "用戶隱私權",          serviceImage: Images.privacy)
        let brandStory      = SettingData(serviceName: "品牌故事",      serviceImage: Images.brandStory)
        return [telephoneNumber, location, email, declaration, inspectReport, privacy, brandStory]
    }

    func setupUI () {
        self.view.backgroundColor = Colors.white
        setNavigationView()
        setupTableView()
        addDelegateAndDataSource()
        addConstraints()
    }
    
    func setNavigationView () {
        self.navigationItem.title = "設定"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeLightBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupTableView () {
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.allowsSelection = true
        tableView.rowHeight = 70
        tableView.isScrollEnabled = true
    }
    
    func addDelegateAndDataSource () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addConstraints () {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - Extension:

extension SettingTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG PRINT: Item in setting \(settings.count)")
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        let setting = settings[indexPath.row]
        cell.serviceImageView.image = setting.serviceImage
        cell.serviceTitleLabel.text = setting.serviceName
        
        // Set up tableView cell when selected will show inside of the corner shape.
        let backgroundView: UIView = UIView()
        backgroundView.backgroundColor = Colors.systemGray6
        backgroundView.layer.cornerRadius = 18
        backgroundView.clipsToBounds = true
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG PRINT:\(indexPath)")
        
    }
}


#Preview {
    UINavigationController(rootViewController: SettingTableViewController())
}
