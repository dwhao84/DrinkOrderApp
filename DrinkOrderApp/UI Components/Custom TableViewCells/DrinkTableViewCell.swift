//
//  DrinkTableViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/19.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {
    
    static let identifier: String = "DrinkTableViewCell"
    
    // MARK: - UI set up:
    var plusImageView: UIImageView = {
        var imageView: UIImageView = UIImageView()
        imageView.image = Images.plusWithCircle
        imageView.tintColor = Colors.kebukeBrown
        return imageView
    } ()
    
    var drinksImageView: UIImageView = {
        var imageView: UIImageView = UIImageView()
        imageView.image = Images.banner03
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var drinksTitleLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "熟成紅茶"
        label.textColor = Colors.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var drinksPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "中: 40 / 大: 45"
        label.textColor = Colors.kebukeBrown
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var drinksDescriptionLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "帶有濃穩果香的經典紅茶"
        label.textColor = Colors.lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    } ()
    
    // MARK: - Life cycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "drinkCell")

        configureStackView()
        addConstraints()
        
        contentView.backgroundColor = Colors.clear
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("DEBUG PRINT: prepareForReuse")
    }
    
    // MARK: - Begin
    func configureStackView () {
        stackView.addArrangedSubview(drinksTitleLabel)
        stackView.addArrangedSubview(drinksPriceLabel)
        stackView.addArrangedSubview(drinksDescriptionLabel)
    }
    
    func addConstraints () {
        contentView.addSubview(drinksImageView)
        drinksImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drinksImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            drinksImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            drinksImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            drinksImageView.widthAnchor.constraint(equalToConstant: 170),
        ])
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.drinksImageView.trailingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])
        
        self.addSubview(plusImageView)
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            plusImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            plusImageView.widthAnchor.constraint(equalToConstant: 35),
            plusImageView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}

#Preview(traits: .fixedLayout(width: 428, height: 150), body: {
    let tableViewCell = DrinkTableViewCell()
    return tableViewCell
})
