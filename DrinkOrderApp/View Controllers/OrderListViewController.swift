//
//  OrderListViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class OrderListViewController: UIViewController {

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

        
    }
    
    func setupUI () {
        addConstraints()
    }
    
    func addDelegateAndDatasource () {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func addConstraints () {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}


#Preview {
    UINavigationController(rootViewController: OrderListViewController())
}
