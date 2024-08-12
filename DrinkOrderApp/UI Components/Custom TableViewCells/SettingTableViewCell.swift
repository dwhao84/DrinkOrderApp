//
//  SettingTableViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/25.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier: String = "SettingTableViewCell"
    
    let serviceImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.phone
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Colors.kebukeBrown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let serviceTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "XXXX"
        label.textColor = Colors.systemGray3
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "reuseIdentifier")

        addConstraints()
        self.contentView.backgroundColor = Colors.white
        accessoryType = .disclosureIndicator
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("DEBUG PRINT: prepareForReuse")
    }
    
    func addConstraints() {
        contentView.addSubview(serviceImageView)
        contentView.addSubview(serviceTitleLabel)
        
        serviceImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        NSLayoutConstraint.activate([
            serviceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            serviceImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            serviceTitleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 20),
            serviceTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}

#Preview(traits: .fixedLayout(width: 428, height: 80), body: {
    let settingTableViewCell: UITableViewCell = SettingTableViewCell()
    return settingTableViewCell
})
