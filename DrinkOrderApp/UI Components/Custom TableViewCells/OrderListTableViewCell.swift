//
//  OrderListTableViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/17.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    static let identifier: String = "OrderListTableViewCell"
    
    let drinksImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Product Sample")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
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
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        
    let mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    private func setupUI () {
        configStackViews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(mainStackView)
        contentView.addSubview(drinksPriceLabel)
        NSLayoutConstraint.activate([
            // contentStackView
            drinksImageView.widthAnchor.constraint(equalToConstant: 170),
            drinksImageView.heightAnchor.constraint(equalTo: drinksImageView.widthAnchor, multiplier: 1),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            // drinksPriceLabel:
            drinksPriceLabel.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 10),
            drinksPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            drinksPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func configStackViews () {
//        contentStackView.layer.borderColor = Colors.red.cgColor
//        contentStackView.layer.borderWidth = 2
//        mainStackView.layer.borderColor = Colors.lightGray.cgColor
//        mainStackView.layer.borderWidth = 2
        
        contentStackView.addArrangedSubview(userNameLabel)
        contentStackView.addArrangedSubview(drinksTitleLabel)
        contentStackView.addArrangedSubview(iceLevelLabel)
        contentStackView.addArrangedSubview(toppingContentLabel)
        contentStackView.addArrangedSubview(qtyLabel)
        
        mainStackView.addArrangedSubview(drinksImageView)
        mainStackView.addArrangedSubview(contentStackView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }    
}


#Preview(traits: .fixedLayout(width: 428, height: 170), body: {
    let orderListTableViewCell: UITableViewCell = OrderListTableViewCell()
    return orderListTableViewCell
})
