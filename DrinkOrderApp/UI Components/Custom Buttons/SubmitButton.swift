//
//  SubmitButton.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/7.
//

import UIKit

class SubmitButton: UIButton {
    
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
        config.baseBackgroundColor = Colors.kebukeLightBlue
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 20)
        config.attributedTitle = AttributedString("Submit", attributes: attributes)
        config.titleAlignment      = .center
        config.cornerStyle         = .large
        config.showsActivityIndicator = false
        self.configuration         = config
        configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ? 0.5 : 1
        }
        // Add Shadow for button.
//        self.layer.shadowColor   = Colors.black.cgColor
//        self.layer.shadowOpacity = 0.6
//        self.layer.shadowOffset  = CGSize(width: 0, height: 5)
//        self.layer.shadowRadius  = 4
//        self.layer.masksToBounds = false
    }
}

#Preview {
    let submitBtn = SubmitButton()
    return submitBtn
}
