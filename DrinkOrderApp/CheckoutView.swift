//
//  CheckoutView.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/23.
//

import UIKit

class CheckoutView: UIView {

    var checkoutTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "🛒 購物車總金額"
        label.textColor = Colors.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var cupCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "共計X杯"
        label.textColor = Colors.systemGray4
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    var totalPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "$XXX"
        label.textColor = Colors.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI ()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup:
    func setupUI () {
        self.backgroundColor = Colors.kebukeLightBlue
    }
    
    func addConstraints () {
        self.addSubview(cupCountLabel)
        self.addSubview(checkoutTitleLabel)
        self.addSubview(totalPriceLabel)
        
        NSLayoutConstraint.activate([
            checkoutTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkoutTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            cupCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cupCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalPriceLabel.leadingAnchor.constraint(equalTo: cupCountLabel.trailingAnchor, constant: 10)
            
        ])
    }
    
}


#Preview(traits: .fixedLayout(width: 428, height: 50), body: {
    let checkoutView: UIView = CheckoutView()
    return checkoutView
})
