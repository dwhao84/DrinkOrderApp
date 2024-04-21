//
//  CustomStepper.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/20.
//

import UIKit

class CustomStepper: UIControl {
    
    var value: Int = 0
    
    let plusStepperBtn: UIButton = {
        let plusStepperBtn: UIButton = UIButton(type: .system)
        var config = UIButton.Configuration.bordered()
        config.image = Images.plus
        config.baseForegroundColor = Colors.darkGray
        config.automaticallyUpdateForSelection = true
        plusStepperBtn.configuration = config
        plusStepperBtn.isUserInteractionEnabled = true
        plusStepperBtn.configurationUpdateHandler = { plusStepperBtn in
            plusStepperBtn.alpha = plusStepperBtn.isHighlighted ? 0.5 : 1
        }
        plusStepperBtn.translatesAutoresizingMaskIntoConstraints = false
        return plusStepperBtn
    } ()
    
    let minusStepperBtn: UIButton = {
        let minusStepperBtn: UIButton = UIButton(type: .system)
        var config = UIButton.Configuration.bordered()
        config.image = Images.minus
        config.baseForegroundColor = Colors.darkGray
        config.automaticallyUpdateForSelection = true
        minusStepperBtn.configuration = config
        minusStepperBtn.isUserInteractionEnabled = true
        minusStepperBtn.translatesAutoresizingMaskIntoConstraints = false
        minusStepperBtn.configurationUpdateHandler = { minusStepperBtn in
            minusStepperBtn.alpha = minusStepperBtn.isHighlighted ? 0.5 : 1
        }
        return minusStepperBtn
    } ()
    
    let numberLabel : UILabel = {
        let label: UILabel = UILabel()
        label.text = "0"
        label.textColor = Colors.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configStackView ()
        addConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configStackView () {
        numberLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(minusStepperBtn)
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(plusStepperBtn)
    }
    
    func addConstraints () {
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func addTargets () {
        minusStepperBtn.addTarget(self, action: #selector(minusStepperBtnTapped), for: .touchUpInside)
        plusStepperBtn.addTarget(self, action: #selector(plusStepperBtnTapped), for: .touchUpInside)
    }
    
    func updateNumberLabel () {
        numberLabel.text = String(value)
        print("DEBUG PRINT: value = \(value)")
    }
    
    @objc func plusStepperBtnTapped (_ sender: UIButton) {
        value += 1
        if value >= 10 {
            value = 10
            print("DEBUG PRINT: value is over than 10")
        }
        updateNumberLabel ()
    }
    
    @objc func minusStepperBtnTapped (_ sender: UIButton) {
        value -= 1
        if value < 0 {
            value = 0
            print("DEBUG PRINT: value is less than 0")
        }
        updateNumberLabel ()
    }
}

#Preview {
    let customStepper = CustomStepper ()
    return customStepper
}
