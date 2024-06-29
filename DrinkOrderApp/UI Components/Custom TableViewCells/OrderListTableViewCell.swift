//
//  OrderListTableViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/17.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    static let identifier: String = "OrderListTableViewCell"
    
    let imageViewWidth: CGFloat = 150.0
    
    let drinksImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.banner02
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading Name..."
        label.textColor = Colors.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let drinksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading drinks..."
        label.textColor = Colors.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toppingContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading 配料..."
        label.numberOfLines = 2
        label.textColor = Colors.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let drinksPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
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
        stackView.alignment = .center
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
        drinksImageView.layer.cornerRadius = imageViewWidth / 7
        self.backgroundColor = Colors.kebukeLightBlue
        self.addSubview(drinksImageView)
        self.addSubview(customStepper)
        self.addSubview(contentStackView)
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            // drinksImageView
            drinksImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            drinksImageView.heightAnchor.constraint(equalTo: drinksImageView.widthAnchor, multiplier: 1),
            drinksImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            drinksImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            // contentStackView
            contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15),
            contentStackView.leadingAnchor.constraint(equalTo: drinksImageView.trailingAnchor, constant: 20),
            
            // Stepper
            customStepper.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            customStepper.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func configStackView () {
        contentStackView.addArrangedSubview(userNameLabel)
        contentStackView.addArrangedSubview(drinksTitleLabel)
        contentStackView.addArrangedSubview(toppingContentLabel)
        contentStackView.addArrangedSubview(drinksPriceLabel)

        mainStackView.addArrangedSubview(drinksImageView)
        mainStackView.addArrangedSubview(contentStackView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func customStepperTapped() {
        
    }
    
}


#Preview(traits: .fixedLayout(width: 428, height: 170), body: {
    let orderListTableViewCell: UITableViewCell = OrderListTableViewCell()
    return orderListTableViewCell
})
