//
//  MailTextField.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/18.
//

import UIKit

class MailTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit () {
        let attributedPlaceholder = NSAttributedString(
            string: "Enter your E-mail",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.lightGray]
        )
        self.attributedPlaceholder = attributedPlaceholder
        self.borderStyle = .roundedRect
        self.isEnabled = true
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = Colors.darkGray
        self.clearButtonMode  = .whileEditing
        self.overrideUserInterfaceStyle = .light
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
