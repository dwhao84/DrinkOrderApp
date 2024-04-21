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
        let imageView = UIImageView()
        imageView.image = Images.banner_01
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let drinksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "熟成紅茶"
        label.textColor = Colors.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let drinksDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "帶有濃穩果香的經典紅茶"
        label.textColor = Colors.kebukeBrown
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let drinksPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$35"
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(drinksImageView)
        contentView.addSubview(drinksTitleLabel)
        contentView.addSubview(drinksDescriptionLabel)
        contentView.addSubview(drinksPriceLabel)
        contentView.addSubview(customStepper)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            drinksImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            drinksImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            drinksImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            drinksImageView.widthAnchor.constraint(equalToConstant: 150),
            
            drinksTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            drinksTitleLabel.leadingAnchor.constraint(equalTo: drinksImageView.trailingAnchor, constant: 20),
            drinksTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            drinksDescriptionLabel.topAnchor.constraint(equalTo: drinksTitleLabel.bottomAnchor, constant: 15),
            drinksDescriptionLabel.leadingAnchor.constraint(equalTo: drinksTitleLabel.leadingAnchor),
            drinksDescriptionLabel.trailingAnchor.constraint(equalTo: drinksTitleLabel.trailingAnchor),
            
            drinksPriceLabel.topAnchor.constraint(equalTo: drinksDescriptionLabel.bottomAnchor, constant: 15),
            drinksPriceLabel.leadingAnchor.constraint(equalTo: drinksTitleLabel.leadingAnchor),
            drinksPriceLabel.trailingAnchor.constraint(equalTo: drinksTitleLabel.trailingAnchor),
                        
            customStepper.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -45),
            customStepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            customStepper.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customStepper.value = 0
    }
}


#Preview(traits: .fixedLayout(width: 428, height: 170), body: {
    let orderListTableViewCell: UITableViewCell = OrderListTableViewCell()
    return orderListTableViewCell
})
