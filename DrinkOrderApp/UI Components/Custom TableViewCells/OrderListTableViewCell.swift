//
//  OrderListTableViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/17.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    static let identifier: String = "OrderListTableViewCell"
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "訂購人姓名"
        label.numberOfLines = 0
        label.textColor = Colors.kebukeLightBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let drinksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "飲料名稱"
        label.numberOfLines = 0
        label.textColor = Colors.kebukeBrown
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toppingContentLabel: UILabel = {
        let label = UILabel()
        label.text = "配料"
        label.numberOfLines = 0
        label.textColor = Colors.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iceLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "冰量"
        label.numberOfLines = 0
        label.textColor = Colors.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let drinksPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "飲料價格"
        label.numberOfLines = 0
        label.textColor = Colors.kebukeBrown
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let qtyLabel: UILabel = {
        let label = UILabel()
        label.text = "數量"
        label.numberOfLines = 0
        label.textColor = Colors.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configStackView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        // Set up cornerRadius
        contentView.addSubview(drinksPriceLabel)
        contentView.backgroundColor = Colors.white
        contentView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            // contentStackView
            contentStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            drinksPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            drinksPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    
    func configStackView () {
        contentStackView.addArrangedSubview(userNameLabel)
        contentStackView.addArrangedSubview(drinksTitleLabel)
        contentStackView.addArrangedSubview(iceLevelLabel)
        contentStackView.addArrangedSubview(toppingContentLabel)
        contentStackView.addArrangedSubview(qtyLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }    
}


#Preview(traits: .fixedLayout(width: 428, height: 170), body: {
    let orderListTableViewCell: UITableViewCell = OrderListTableViewCell()
    return orderListTableViewCell
})
