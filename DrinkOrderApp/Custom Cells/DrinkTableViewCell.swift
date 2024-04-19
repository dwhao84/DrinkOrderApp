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
    var drinksImageView: UIImageView = {
        var imageView: UIImageView = UIImageView()
        imageView.image = Images.banner_03
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var drinksTitleLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "熟成紅茶"
        label.textColor = Colors.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var drinksDescriptionLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "帶有濃穩果香的經典紅茶"
        label.textColor = Colors.kebukeBrown
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var drinksPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "$"
        label.textColor = Colors.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 15
        return stackView
    } ()
    
    // MARK: - Life cycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "DrinkTableViewCell")
        

        configureStackView()
        addConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func setHighlighted(_ highlighted: Bool, animated: Bool) {
         super.setHighlighted(highlighted, animated: animated)
         if highlighted {
             // 在按住時修改 cell 的樣式

         } else {
             // 在放開時恢復 cell 的正常樣式

         }
     }
    
    
    func configureStackView () {
        stackView.addArrangedSubview(drinksTitleLabel)
        stackView.addArrangedSubview(drinksDescriptionLabel)
        stackView.addArrangedSubview(drinksPriceLabel)
    }
    
    func addConstraints () {
        self.addSubview(drinksImageView)
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
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

#Preview(traits: .fixedLayout(width: 428, height: 150), body: {
    let tableViewCell = DrinkTableViewCell()
    return tableViewCell
})
