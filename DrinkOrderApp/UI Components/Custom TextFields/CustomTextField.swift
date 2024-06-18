//
//  CustomTextField.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/7.
//

import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit () {
        self.borderStyle = .roundedRect
        self.isEnabled = true
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = Colors.darkGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

#Preview {
    let customTextField = CustomTextField()
    return customTextField
}
