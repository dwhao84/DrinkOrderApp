//
//  SettingTableViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class SettingTableViewController: UIViewController {

    // MARK: - UI set up:
    var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = Colors.kebukeLightBlue
        tableView.estimatedRowHeight = 100
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    // MARK: - Life cycle:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = Colors.kebukeBrown
    }

    
}

// MARK: - Extension:



#Preview {
    UINavigationController(rootViewController: SettingTableViewController())
}
