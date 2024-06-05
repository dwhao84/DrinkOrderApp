//
//  OrderDetailViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/18.
//

import UIKit
import Kingfisher

class OrderDetailViewController: UIViewController {
    
    let cupSize: [String] = ["中杯 M", "大杯 L"]
    let sugarLevel: [String] = ["正常糖", "少糖", "半糖", "微糖", "二分糖", "一分糖", "無糖"]
    let iceLevel: [String] = ["正常冰", "少冰", "微冰", "去冰", "完全去冰", "常溫", "溫", "熱"]
    
    
    // MARK: - Passing Data:
    var drinksName: String?
    var drinksDescription: String?
    var drinksImageURL: String?
    
    var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = Colors.kebukeDarkBlue
        tableView.isScrollEnabled = true
        return tableView
    }()

    // Show the product image at the top.
    let drinksImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.photoFill
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.kebukeLightBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let drinkNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let drinkDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Drink Description Label"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let sugarLevelLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Sugar Level 糖量"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var sugarLevelPickerView: UIPickerView = {
        let pickerView: UIPickerView = UIPickerView()
        return pickerView
    } ()
    
    let iceLevelLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Ice Level 冰量"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = Colors.kebukeLightBlue
        scrollView.showsHorizontalScrollIndicator = true
        return scrollView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        // MARK: - Update UI
        
        guard let url = drinksImageURL else {
            print("Unable to get drinksURL")
            return
        }
        
        drinkNameLabel.text        = drinksName
        drinkDescriptionLabel.text = drinksDescription
        let drinksImageUrl = URL(string: url)
        drinksImageView.kf.setImage(with: drinksImageUrl)
    }
    
    func setupUI () {
        setNavigationView()
        view.addSubview(drinksImageView)
        addConstraints()
        self.view.backgroundColor = Colors.white
    }
    

    func setNavigationView () {
        self.navigationItem.title = drinksName
        print("\(String(describing: drinksName))")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeLightBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func addConstraints () {
        scrollView.delegate = self
        drinksImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drinksImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            drinksImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drinksImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drinksImageView.heightAnchor.constraint(equalTo: drinksImageView.widthAnchor, multiplier: 0.57)
        ])
    }
}

extension OrderDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

#Preview {
    UINavigationController(rootViewController: OrderDetailViewController())
}
