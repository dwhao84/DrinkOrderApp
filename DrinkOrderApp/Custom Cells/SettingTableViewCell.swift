//
//  SettingTableViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/25.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier: String = "SettingTableViewCell"
    
    var serviceImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.phone
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Colors.kebukeLightBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var serviceTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "XXXX"
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "drinkCell")

        addConstraints()
        self.backgroundColor = Colors.white
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addSubview(serviceImageView)
        self.addSubview(serviceTitleLabel)
        
        serviceImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        NSLayoutConstraint.activate([
            serviceImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            serviceImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            serviceTitleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 20),
            serviceTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}

#Preview(traits: .fixedLayout(width: 428, height: 80), body: {
    let settingTableViewCell: UITableViewCell = SettingTableViewCell()
    return settingTableViewCell
})
