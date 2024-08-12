//
//  CancelButton.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/7/8.
//

import UIKit

class CancelButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        var config = UIButton.Configuration.plain()
        config.title = "取消"
        config.baseForegroundColor = Colors.kebukeLightBlue
        self.configuration = config
        
        self.configurationUpdateHandler = { button in
            let config = button.configuration
            button.alpha = button.isHighlighted ? 0.5 : 1
            button.configuration = config
        }
    }}
