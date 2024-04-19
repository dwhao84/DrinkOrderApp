//
//  OrderListTableViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/17.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    static let identifier: String = "OrderListTableViewCell"
    
    // MARK: - UI set up:
    var drinksImageView: UIImageView = {
        var imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFit
        
        let imageViewWidth: CGFloat = imageView.bounds.width
        imageView.layer.cornerRadius = imageViewWidth / 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var drinksTitleLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "熟成紅茶"
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var drinksDescriptionLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "帶有濃穩果香的經典紅茶"
        label.textColor = Colors.kebukeBrown
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var drinksPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "$"
        label.textColor = Colors.kebukeBrown
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var drinksStepper: UIStepper = {
        let stepper: UIStepper = UIStepper()
        stepper.value = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.wraps = true
        stepper.isContinuous = true
        stepper.autorepeat = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    } ()
    
    var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    } ()
    
    
    // MARK: - Life Cycle:
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("DEBUG PRINT: prepareForReuse")
    }
    
}
