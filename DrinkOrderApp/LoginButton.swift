//
//  LoginButton.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class LoginButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        
        var config                 = UIButton.Configuration.filled()
        config.baseBackgroundColor = Colors.kebukeBrown
        config.title               = "Login"
        config.titleAlignment      = .center
        config.cornerStyle         = .large
        self.configuration         = config

        configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ? 0.5 : 1
        }
    }
}
