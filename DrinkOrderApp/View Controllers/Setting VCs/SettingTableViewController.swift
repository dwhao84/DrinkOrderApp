//
//  SettingTableViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit
import MessageUI
import SafariServices

class SettingTableViewController: UIViewController {
    
    var settings: [SettingData] = []
    
    // MARK: - UI set up:
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 60
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Into the SettingVC")
        setupUI()
        settings = fetchSettingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func fetchSettingData () -> [SettingData] {
        // First group -> Contact Information.
        let telephoneNumber = SettingData(serviceName: "聯絡我們", serviceImage: Images.phone, color: Colors.kebukeLightBlue)
        let location        = SettingData(serviceName: "門市據點", serviceImage: Images.map, color: Colors.kebukeLightBlue)
        let email           = SettingData(serviceName: "店家信箱", serviceImage: Images.mail, color: Colors.kebukeLightBlue)
        
        // Second group -> Company Information.
        let declaration     = SettingData(serviceName: "聲明公告", serviceImage: Images.declaration, color: Colors.kebukeLightBlue)
        let inspectReport   = SettingData(serviceName: "檢驗報告", serviceImage: Images.report, color: Colors.kebukeLightBlue)
        let privacy         = SettingData(serviceName: "用戶隱私權", serviceImage: Images.privacy, color: Colors.kebukeLightBlue)
        let brandStory      = SettingData(serviceName: "品牌故事", serviceImage: Images.brandStory, color: Colors.kebukeLightBlue)
        return [telephoneNumber, location, email, declaration, inspectReport, privacy, brandStory]
    }
    
    func setupUI () {
        self.tabBarController?.tabBar.isHidden = false
        setNavigationView()
        setupTableView()
        addDelegateAndDataSource()
        addConstraints()
    }
    
    func setNavigationView () {
        let navigationTitle = UILabel()
        navigationTitle.font = UIFont.boldSystemFont(ofSize: 20)
        navigationTitle.textColor = Colors.white
        navigationTitle.text = "設定"
        navigationTitle.minimumScaleFactor = 0.3
        navigationTitle.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView = navigationTitle
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeDarkBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: setup TableView
    func setupTableView () {
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.allowsSelection = true
        tableView.isScrollEnabled = true
    }
    
    // MARK: Add Delegates & DataSources
    func addDelegateAndDataSource () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Add Constraints:
    func addConstraints () {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Make a call
    func callPhoneNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                print("DEBUG PRINT: 無法撥打可不可的客服電話")
            }
        }
    }
    
    // MARK: sendEmail
    func sendEmail () {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients(["info@kebuke.com"])
            mailComposeViewController.setSubject("Your Subject")
            mailComposeViewController.setMessageBody("Your message body.", isHTML: false)
            // Present the view controller modally.
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            AlertManager.showButtonAlert(on: self, title: "寄件失敗", message: "請重新確認是否郵件正確")
        }
    }
    
    // MARK: show Inspect Report
    func showInspectReport () {
        guard let url = URL(string:"https://kebuke.com/report/") else {
            print("Unable to get Inspect Report")
            return
        }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
    
    // MARK: show Privacy Content
    func showPrivacyContent () {
        guard let url = URL(string:"https://www.kebuke.com/privacy/") else {
            print("Unable to get privacy content")
            return
        }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
    
    // MARK: show Announcement:
    func showAnnouncement () {
        guard let url = URL(string:"https://www.kebuke.com/announcement/20210319/") else {
            print("Unable to get announcement")
            return
        }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
    
    // MARK: show Brand Story:
    func showBrandStory () {
        guard let url = URL(string:"https://www.kebuke.com/about/") else {
            print("Unable to get Brand Story")
            return
        }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
}

// MARK: - Extension:
extension SettingTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG PRINT: Item in setting \(settings.count)")
        return settings.count
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        var content = cell.defaultContentConfiguration()
        let setting = settings[indexPath.row]
        content.image = setting.serviceImage
        content.imageProperties.tintColor = setting.color
        content.text = setting.serviceName
        content.textProperties.color = Colors.darkGray
        
        // Set up tableView cell when selected will show inside of the corner shape.
        let backgroundView: UIView = UIView()
        backgroundView.backgroundColor = Colors.lightGray
        backgroundView.layer.cornerRadius = 10
        backgroundView.clipsToBounds = true
        cell.selectedBackgroundView = backgroundView
        
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG PRINT:\(indexPath)")
        switch indexPath.row  {
        case 0:
            print("DEBUG PRINT: 撥打客服電話")
            callPhoneNumber(phoneNumber: "+(886)0800-000-961")
            
        case 1:
            print("DEBUG PRINT: 門市據點")
            let storeLocationVC = StoreLocationViewController()
            storeLocationVC.navigationItem.title = "門市據點"
            storeLocationVC.modalPresentationStyle = .overFullScreen
            self.navigationController?.pushViewController(storeLocationVC, animated: true)
            
        case 2:
            print("DEBUG PRINT: 點擊 店家信箱")
            sendEmail()
            
        case 3:
            print("DEBUG PRINT: 點擊 聲明公告")
            showAnnouncement()
        case 4:
            print("DEBUG PRINT: 點擊 檢驗報告")
            showInspectReport()
        case 5:
            print("DEBUG PRINT: 點擊 用戶隱私權")
            showPrivacyContent()
        case 6:
            print("DEBUG PRINT: 點擊 品牌故事")
            showBrandStory()
        default:
            break
        }
        tableView.reloadData()
    }
    
    // MARK: viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Colors.clear // Customize your header background color
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14) // Set your desired font size
        label.textColor = Colors.darkGray
        label.text = "店家相關資訊"
        headerView.addSubview(label)
        
        // Add constraints to label
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
        return headerView
    }
    
    // MARK: heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK: extension: MFMailComposeVC
extension SettingTableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

#Preview {
    UINavigationController(rootViewController: SettingTableViewController())
}
