//
//  RegisterViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit
//import FirebaseAuth

class RegisterViewController: UIViewController {
    
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
        
        enterNameStatusLabel.isHidden = true
        enterEmailStatusLabel.isHidden = true
        enterPasswordStatusLabel.isHidden = true
    }
    
    // MARK: - Beginning to set up:
    func setupUI () {
        self.view.backgroundColor = Colors.kebukeDarkBlue
        addConstraints()
        addTextFieldsDelegate ()
        addTargets ()
    }
    
    func addTargets () {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func addTextFieldsDelegate () {
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
        nameStackView.addArrangedSubview(enterNameStatusLabel)
        
        mailStackView.addArrangedSubview(mailLabel)
        mailStackView.addArrangedSubview(mailTextField)
        mailStackView.addArrangedSubview(enterEmailStatusLabel)
        
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
        let password = passwordTextField.text ?? ""
        let email = mailTextField.text ?? ""
        
        let passwordCheckResult = checkPasswordCorrection(password)
        let emailCheckResult = checkEmailResult(email)
        
        // 檢查 password 是否正確
        if passwordCheckResult != .valid {
            switch passwordCheckResult {
            case .valid:
                print("輸入密碼成功")
                enterPasswordStatusLabel.isHidden = true
                
            case .containsCommonPassword:
                print("密碼是常使用密碼，建議更換")
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼是常使用密碼，建議更換"
                
            case .lacksDigits:
                print("缺少數字")
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼缺少數字"
                
            case .lacksPunctuation:
                print("密碼輸入錯誤的內容")
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼輸入錯誤的內容"
                
            case .lackTextLength:
                print("密碼長度內容有誤")
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼長度內容有誤"
                
            case .empty:
                print("密碼空白")
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼空白"
            }
        } else if passwordCheckResult == .valid {
            print("密碼輸入成功")
            enterPasswordStatusLabel.isHidden = true
        }
        
        // 檢查 email 是否正確
        switch emailCheckResult {
        case .valid:
            print("E-mail 輸入成功")
            enterEmailStatusLabel.isHidden = true
        case .lackCorrection:
            print("E-mail 輸入不正確")
            enterEmailStatusLabel.text = "E-mail 輸入不正確"
            enterEmailStatusLabel.isHidden = false
        case .lackAt:
            print("E-mail 缺少@")
            enterEmailStatusLabel.text = "E-mail 缺少@"
            enterEmailStatusLabel.isHidden = false
        case .invalidDomain:
            print("郵件輸入內容缺少網域")
            enterEmailStatusLabel.text = "郵件輸入內容缺少Domain"
            enterEmailStatusLabel.isHidden = false
        }
        
        if passwordCheckResult == .valid && emailCheckResult != .valid {
            print("郵件輸入錯誤")
        } else if passwordCheckResult != .valid && emailCheckResult == .valid {
            print("密碼輸入錯誤")
        } else {
            print("密碼 / 郵件 輸入正確")
            let loginVC: UIViewController = LoginViewController()
            self.present(loginVC, animated: true)
        }
        
    }
    
    func checkPasswordCorrection(_ password: String) -> PasswordCheck {
        let tenCommonPasswords = ["123456", "123456789", "qwerty", "password", "12345678", "111111", "iloveyou", "1q2w3e", "123123", "password1"]
        let digits = "0123456789"
        let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
        let textLength = Int(passwordTextField.text?.count ?? 0)
        
        if tenCommonPasswords.contains(password) { return .containsCommonPassword }
        else if !digits.contains(where: { digits.contains($0) }) { return .lacksDigits }
        else if password.contains(where: { punctuation.contains($0) }) { return .lacksPunctuation }
        else if textLength < 16 && textLength > 30 { return .lackTextLength }
        else { return .valid }
    }
    
    func checkEmailResult(_ email: String) -> EmailCheck {
        let emailAddress: [String] = ["@gmail.com", "@yahoo.com.tw"]
        let punctuation = "!#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
        
        if !email.contains("@") {
            print("DEBUG PRINT: 郵件地址缺少@")
            return .lackAt
        }
        if email.contains(where: { punctuation.contains($0)}) {
            print("DEBUG PRINT: 郵件地址內容不太正確")
            return .lackCorrection
        }
        if !emailAddress.contains(where: { email.contains($0)}) {
            print("DEBUG PRINT: 郵件地址網域不正確")
            return .invalidDomain
        }
        return .valid
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
        print("textField Should EndEditing")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textField Should Return")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textField Did Begin Editing")
        textField.becomeFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textField Did Change Selection")
        print("DEBUG PRINT: \(textField.text ?? "")")
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textField Should Clear")
        
        textField.text = ""
        return true
    }
}

#Preview {
    let registerVC = RegisterViewController()
    return registerVC
}
