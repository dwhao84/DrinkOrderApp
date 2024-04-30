//
//  RegisterViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    // MARK: - UIImageView
    var logoImageView: UIImageView = {
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image       = Images.kebukeLoginLogo
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    } ()
    
    // MARK: - UITextField
    var nameTextField: UITextField = {
        let nameTextField: UITextField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "Enter your name",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.kebukeBrown]
        )
        nameTextField.attributedPlaceholder = attributedPlaceholder
        nameTextField.borderStyle      = .roundedRect
        nameTextField.textColor        = Colors.darkGray
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    } ()
    
    var mailTextField: UITextField = {
        let mailTextField: UITextField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "Enter your mail",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.kebukeBrown]
        )
        mailTextField.attributedPlaceholder = attributedPlaceholder
        mailTextField.borderStyle      = .roundedRect
        mailTextField.textColor        = Colors.darkGray
        mailTextField.clearButtonMode = .whileEditing
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        return mailTextField
    } ()
    
    var passwordTextField: UITextField = {
        let passwordTextField: UITextField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.kebukeBrown]
        )
        passwordTextField.attributedPlaceholder = attributedPlaceholder
        passwordTextField.borderStyle      = .roundedRect
        passwordTextField.textColor        = Colors.darkGray
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    } ()
    
    
    // MARK: - UIButton:
    var registerButton: SecRegisterButton = {
        let button = SecRegisterButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // MARK: - UILabel
    var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Enter your name:"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var mailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Enter your E-mail:"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var passwordLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Enter your Password:"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // MARK: - UIStackView:
    var nameStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    var mailStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    var passwordStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    var mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 35
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Into the RegisterVC")
        setupUI()
        
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeDarkBlue
        addConstraints()
        addDelegates ()
        addTargets ()
        
    }
    
    func addTargets () {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func addDelegates () {
        nameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func addConstraints () {
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        mailStackView.addArrangedSubview(mailLabel)
        mailStackView.addArrangedSubview(mailTextField)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)

        mainStackView.addArrangedSubview(nameStackView)
        mainStackView.addArrangedSubview(mailStackView)
        mainStackView.addArrangedSubview(passwordStackView)
        mainStackView.addArrangedSubview(registerButton)
        
        view.addSubview(logoImageView)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            
            logoImageView.widthAnchor.constraint(equalToConstant: 280),
            logoImageView.heightAnchor.constraint(equalToConstant: 45),
            nameTextField.widthAnchor.constraint(equalToConstant: 280),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.widthAnchor.constraint(equalToConstant: 280),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            mailTextField.widthAnchor.constraint(equalToConstant: 280),
            mailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Register Button
            registerButton.widthAnchor.constraint(equalToConstant: 280),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Logo ImageView:
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Main StackView:
            mainStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func registerButtonTapped (_ sender: UIButton) {
        print("registerButtonTapped")
        showSuccessAC()
    }
    
    func showSuccessAC () {
        let controller = UIAlertController(
            title: """
            註冊成功
            Register Success
            """,
            message: "",
            preferredStyle: .alert
        )
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(controller, animated: true, completion: nil)
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        textField.becomeFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear")
        textField.text = ""
        return true
    }
}

#Preview {
    let registerVC = RegisterViewController()
    return registerVC
}
