//
//  RegisterViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    // Create the condiction for register.
    let word: String       = "abcdefghijklmnopqrstuvwxyz"
    let digit: String      = "0123456789"
    let correction: String = "&=_'-+,<>."
    
    // MARK: - UIImageView:
    let logoImageView: UIImageView = {
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image       = Images.kebukeLoginLogo
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    } ()
    
    // MARK: - UITextField:
    let nameTextField: NameTextField = {
        let nameTextField: NameTextField = NameTextField()
        return nameTextField
    } ()
    
    let mailTextField: MailTextField = {
        let mailTextField: MailTextField = MailTextField()
        return mailTextField
    } ()
    
    let passwordTextField: PasswordTextField = {
        let passwordTextField: PasswordTextField = PasswordTextField()
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    } ()
    
    
    // MARK: - UIButton:
    let registerButton: SecRegisterButton = {
        let button = SecRegisterButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // MARK: - UILabel:
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Enter your name:"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let mailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Enter your E-mail:"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let passwordLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Enter your Password:"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let enterNameStatusLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "狀態"
        label.textColor = Colors.red
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let enterEmailStatusLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "狀態"
        label.textColor = Colors.red
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let enterPasswordStatusLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "狀態"
        label.textColor = Colors.red
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // MARK: - UIStackView:
    let nameStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let mailStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let passwordStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Into the RegisterVC")
        setupUI()
        
        enterPasswordStatusLabel.isHidden = true
    }
    
    // MARK: - Beginning to set up:
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
        let imageViewWidth: Double = self.view.bounds.width - 100.0
        logoImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: imageViewWidth * 0.7).isActive = true
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        mailStackView.addArrangedSubview(mailLabel)
        mailStackView.addArrangedSubview(mailTextField)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(enterPasswordStatusLabel)
        
        mainStackView.addArrangedSubview(logoImageView)
        mainStackView.addArrangedSubview(nameStackView)
        mainStackView.addArrangedSubview(mailStackView)
        mainStackView.addArrangedSubview(passwordStackView)
        mainStackView.addArrangedSubview(registerButton)
        
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            // name TextField
            nameTextField.widthAnchor.constraint(equalToConstant: 280),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // password TextField
            passwordTextField.widthAnchor.constraint(equalToConstant: 280),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Mail TextField
            mailTextField.widthAnchor.constraint(equalToConstant: 280),
            mailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Register Button
            registerButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 180),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Main StackView:
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Action:
    @objc func registerButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = mailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // 如果其中一個欄位是空的，顯示相應的錯誤提示。
            if nameTextField.text == "" {
                showAlertVC(title: "缺少姓名資料", message: "")
                
            } else if mailTextField.text == "" {
                showAlertVC(title: "缺少信箱資料", message: "")
                
            } else if passwordTextField.text == "" {
                showAlertVC(title: "缺少密碼資料", message: "")
            }
            return
        }
        
        // 使用電子郵件和密碼註冊新用戶
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // 處理可能的錯誤，如郵件格式錯誤或密碼不符合要求等
                let errorAlert = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(errorAlert, animated: true)
                return
            }
            // 註冊成功後，顯示成功訊息
            self.showAlertVC(title: "註冊成功 Register Success", message: "")
        }
    }

    
    // MARK: - Alert Controller:
    func showAlertVC (title: String, message: String) {
        let controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK: - Extension:
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
        print("DEBUG PRINT: \(textField.text ?? "")")
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
