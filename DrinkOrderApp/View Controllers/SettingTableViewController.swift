//
//  SettingTableViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class SettingTableViewController: UIViewController {

    var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = Colors.kebukeLightBlue
        tableView.estimatedRowHeight = 100
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = Colors.kebukeBrown
    }

    
}

#Preview {
    UINavigationController(rootViewController: SettingTableViewController())
}
