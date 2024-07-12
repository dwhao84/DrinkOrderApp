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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = Colors.kebukeLightBlue
        tableView.rowHeight = 100
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
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
    
    func fetchSettingData () -> [SettingData] {
        // First group -> Contact Information.
        let telephoneNumber = SettingData(serviceName: "聯絡我們", serviceImage: Images.phone)
        let location        = SettingData(serviceName: "門市據點",         serviceImage: Images.map)
        let email           = SettingData(serviceName: "店家信箱",           serviceImage: Images.mail)
        
        // Second group -> Company Information.
        let declaration     = SettingData(serviceName: "聲明公告",      serviceImage: Images.declaration)
        let inspectReport   = SettingData(serviceName: "檢驗報告",  serviceImage: Images.report)
        let privacy         = SettingData(serviceName: "用戶隱私權",          serviceImage: Images.privacy)
        let brandStory      = SettingData(serviceName: "品牌故事",      serviceImage: Images.brandStory)
        return [telephoneNumber, location, email, declaration, inspectReport, privacy, brandStory]
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.white
        self.tabBarController?.tabBar.isHidden = false
        setNavigationView()
        setupTableView()
        addDelegateAndDataSource()
        addConstraints()
    }
    
    func setNavigationView () {
        self.navigationItem.title = "設定"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeDarkBlue
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
            // Alert the user that mail services are not available.
            let alert = UIAlertController(title: "Cannot Send Email", message: "Please check e-mail configuration and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showInspectReport () {
        guard let url = URL(string:"https://kebuke.com/report/") else {
            print("Unable to get Inspect Report")
            return
        }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
    
    func showPrivacyContent () {
        guard let url = URL(string:"https://www.kebuke.com/privacy/") else {
            print("Unable to get privacy content")
            return
        }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
    
    func showAnnouncement () {
        guard let url = URL(string:"https://www.kebuke.com/announcement/20210319/") else {
            print("Unable to get announcement")
            return
        }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
    
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
        backgroundView.backgroundColor = Colors.kebukeDarkBlueWithAlpha
        backgroundView.layer.cornerRadius = 18
        backgroundView.clipsToBounds = true
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG PRINT:\(indexPath)")
        
        // The row's value is start from 0 to 6.
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
    }
}

extension SettingTableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}


#Preview {
    UINavigationController(rootViewController: SettingTableViewController())
}
