//
//  CheckingPasswordButton.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/25.
//

import UIKit

class CheckingPasswordButton: UIButton {
    
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
        config.buttonSize = .large
        config.baseForegroundColor = Colors.lightGray
        config.image = Images.eyeCircle
        self.configuration = config
        
        self.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.image = button.isHighlighted ? Images.eyeCircle : Images.eyeCircle
            button.configuration = config
        }
    }
}


#Preview {
    let checkingPasswordBtn = CheckingPasswordButton()
    return checkingPasswordBtn
}
