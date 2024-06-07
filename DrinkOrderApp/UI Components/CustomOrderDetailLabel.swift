//
//  CustomOrderDetailLabel.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/7.
//

import UIKit

class CustomOrderDetailLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit () {
        self.font = UIFont.boldSystemFont(ofSize: 15)
        self.textColor = Colors.darkGray
        self.textAlignment = .left
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
