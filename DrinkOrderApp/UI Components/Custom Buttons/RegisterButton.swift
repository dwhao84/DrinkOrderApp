//
//  RegisterButton.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit

class RegisterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        
        var config                 = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.kebukeLightBlue
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 18)
        config.attributedTitle = AttributedString("註冊", attributes: container)
        config.titleAlignment      = .center
        config.cornerStyle         = .capsule
        config.background.strokeColor = Colors.kebukeLightBlue
        config.background.strokeWidth = 1
        config.showsActivityIndicator = false
        self.configuration         = config

        configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ? 0.5 : 1
        }
    }
}

#Preview {
    let registerBtn = RegisterButton()
    return registerBtn
}
