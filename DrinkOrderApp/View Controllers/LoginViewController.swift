//
//  LoginViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // logoImageView
    var logoImageView: UIImageView = {
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image       = Images.kebukeLoginLogo
        logoImageView.contentMode = .scaleToFill
        return logoImageView
    } ()
    
    // enterNameTextField
    var enterNameTextField: UITextField = {
        let enterNameTextField: UITextField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "Enter your name",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.kebukeBrown]
        )
        enterNameTextField.attributedPlaceholder = attributedPlaceholder
        enterNameTextField.borderStyle      = .roundedRect
        enterNameTextField.textColor        = Colors.darkGray
        enterNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return enterNameTextField
    } ()
    
    // loginButton
    var loginButton: LoginButton = {
        let button = LoginButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // stackView
    var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis             = .vertical
        stackView.alignment        = .center
        stackView.spacing          = 25
        stackView.distribution     = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // secondStackView
    var secondStackView: UIStackView = {
        let secondStackView: UIStackView = UIStackView()
        secondStackView.axis             = .vertical
        secondStackView.alignment        = .center
        secondStackView.spacing          = 0
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        return secondStackView
    } ()
    
    var thirdStackView: UIStackView = {
        let thirdStackView: UIStackView = UIStackView()
        thirdStackView.axis             = .vertical
        thirdStackView.alignment        = .center
        thirdStackView.spacing          = 0
        thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        return thirdStackView
    } ()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.kebukeDarkBlue
        setupLayout()
    }
    
    
    func setupLayout() {
        // Add elements to the stack view
//        enterNameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        enterNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        enterNameTextField.widthAnchor.constraint(equalToConstant: 280).isActive = true
        enterNameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        loginButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let imageViewWidth: Double = 320
        logoImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: imageViewWidth * 0.7).isActive = true
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(enterNameTextField)
        stackView.addArrangedSubview(loginButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
}

#Preview {
    UINavigationController(rootViewController: LoginViewController())
}
