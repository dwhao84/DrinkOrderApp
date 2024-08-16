//
//  SecRegisterButton.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit

class SecRegisterButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        
        var config                 = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 18)
        config.attributedTitle = AttributedString("註冊", attributes: container)
        config.titleAlignment      = .center
        config.cornerStyle         = .capsule
        config.background.strokeColor = Colors.kebukeLightBlue
        config.background.strokeWidth = 1
        config.baseForegroundColor = Colors.kebukeLightBlue
        config.baseBackgroundColor = Colors.white
        self.configuration         = config

        configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ? 0.5 : 1
        }
    }
}

#Preview {
    let registerBtn = SecRegisterButton()
    return registerBtn
}
