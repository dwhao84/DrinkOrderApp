//
//  AuthSelectionViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/18.
//

import UIKit

class AuthSelectionViewController: UIViewController {
    
    // MARK: - Custom UI for UIImageView:
    var logoImageView: UIImageView = {
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image = Images.firstPage
        logoImageView.contentMode = .scaleAspectFill
        return logoImageView
    } ()
    
    
    // MARK: - Custom UI for UIButton:
    // loginButton
    var loginButton: LoginButton = {
        let button = LoginButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // Register
    var registerButton: RegisterButton = {
        let button = RegisterButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // MARK: - Custom UI for UIStackView:
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
    
    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Into the AuthVC")
        self.view.backgroundColor = Colors.white
        setupUI()
        addTargets()
    }
    
    func addTargets () {
        loginButton.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
    }
    
    @objc func loginBtnTapped (_ sender: UIButton) {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .popover
        self.present(loginVC, animated: true)
        print("DEBUG PRINT: loginBtnTapped")
    }
    
    @objc func registerBtnTapped (_ sender: UIButton) {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .popover
        self.present(registerVC, animated: true)
        print("DEBUG PRINT: registerBtnTapped")
    }
    
    // MARK: - Setup UI:
    func setupUI() {
        let customWidth: CGFloat = self.view.bounds.width - 180
        let customHeight: CGFloat = 50
 
        [loginButton, registerButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: customWidth).isActive = true
            $0.heightAnchor.constraint(equalToConstant: customHeight).isActive = true
        }
        
        let imageViewWidth: Double = self.view.bounds.width - 60.0
        logoImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: imageViewWidth * 0.7).isActive = true
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

// MARK: - Extenstion:
extension AuthSelectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("DEBUG PRINT: textFieldShouldReturn")
        
        if textField.text == "" {
            print("DEBUG PRINT: textField is empty.")
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("""
              DEBUG PRINT: textFieldDidChangeSelection
              \(textField.text ?? "")
              """)
    }
}

#Preview {
    UINavigationController(rootViewController: AuthSelectionViewController())
}
