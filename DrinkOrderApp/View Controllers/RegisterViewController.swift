//
//  RegisterViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    enum Condition {
        // Create the condiction for register.
        static let word: String       = "abcdefghijklmnopqrstuvwxyz"
        static let digit: String      = "0123456789"
        static let correction: String = "&=_'-+,<>."
        static let tenCommonPasswords = ["123456", "123456789", "qwerty", "password", "12345678", "111111", "iloveyou", "1q2w3e", "123123", "password1"]
        static let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
        static let mailAddress = "@gmail.com, @yahoo.com.tw"
    }
    
    // MARK: - UIImageView:
    let logoImageView: UIImageView = {
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image       = Images.firstPage
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
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
    
    let mailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "輸入郵件:"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let passwordLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "輸入密碼:"
        label.textColor = Colors.white
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
        
        enterEmailStatusLabel.isHidden = true
        enterPasswordStatusLabel.isHidden = true
    }
    
    // MARK: - Beginning to set up:
    func setupUI () {
        self.view.backgroundColor = Colors.white
        addConstraints()
        addTextFieldsDelegate ()
        addTargets ()
    }
    
    // MARK: - addTargets
    func addTargets () {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - addTextFieldsDelegate
    func addTextFieldsDelegate () {
        mailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - addConstraints
    func addConstraints () {
        let imageViewWidth: Double  = self.view.bounds.width - 100.0
        let btnWidth: Double        = self.view.bounds.width - 180.0
        let btnHeight: Double       = 50.0
        let textFieldWidth: Double  = 280.0
        let textFieldHeight: Double = 45.0
        
        logoImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: imageViewWidth * 0.7).isActive = true
        
        mailStackView.addArrangedSubview(mailLabel)
        mailStackView.addArrangedSubview(mailTextField)
        mailStackView.addArrangedSubview(enterEmailStatusLabel)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(enterPasswordStatusLabel)
        
        mainStackView.addArrangedSubview(logoImageView)
        mainStackView.addArrangedSubview(mailStackView)
        mainStackView.addArrangedSubview(passwordStackView)
        mainStackView.addArrangedSubview(registerButton)
        
        [mailTextField, passwordTextField].forEach {
            $0.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
            $0.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        }
        
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            // Register Button
            registerButton.widthAnchor.constraint(equalToConstant: btnWidth),
            registerButton.heightAnchor.constraint(equalToConstant: btnHeight),
            
            // Main StackView:
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    // MARK: - Check Password correction
    func checkPasswordCorrection(_ password: String) -> PasswordCheck {
        let digits = "0123456789"
        let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
        let textLength = Int(passwordTextField.text?.count ?? 0)
        
        if textLength == 0 {
            print("DEBUG PRINT: Password is empty")
            return .empty
            
        } else if !password.contains(where: { digits.contains($0) }) {
            print("DEBUG PRINT: Password is missing digits")
            return .lacksDigits
            
        } else if !password.contains(where: { punctuation.contains($0) }) {
            print("DEBUG PRINT: Password is uncorrect")
            return.lacksPunctuation
            
        } else if textLength < 4 && textLength > 121 {
            print("""
                 DEBUG PRINT: Password's text length is not correct
                \(textLength)
                """)
            return .lackTextLength
        } else {
            print("DEBUG PRINT: Password is valid")
            return .valid }
    }
    
    // MARK: - Check Mail Correction:
    func checkEmailCorrection(_ email: String) -> EmailCheck {
        let emailDomains = [
            "gmail.com", "yahoo.com", "hotmail.com", "aol.com", "hotmail.co.uk",
            "hotmail.fr", "msn.com", "yahoo.fr", "wanadoo.fr", "orange.fr",
            "comcast.net", "yahoo.co.uk", "yahoo.com.br", "yahoo.co.in", "live.com",
            "rediffmail.com", "free.fr", "gmx.de", "web.de", "yandex.ru",
            "ymail.com", "libero.it", "outlook.com", "uol.com.br", "bol.com.br",
            "mail.ru", "cox.net", "hotmail.it", "sbcglobal.net", "sfr.fr",
            "live.fr", "verizon.net", "live.co.uk", "googlemail.com", "yahoo.es",
            "ig.com.br", "live.nl", "bigpond.com", "terra.com.br", "yahoo.it",
            "neuf.fr", "yahoo.de", "alice.it", "rocketmail.com", "att.net",
            "laposte.net", "facebook.com", "bellsouth.net", "yahoo.in", "hotmail.es",
            "charter.net", "yahoo.ca", "yahoo.com.au", "rambler.ru", "hotmail.de",
            "tiscali.it", "shaw.ca", "yahoo.co.jp", "sky.com", "earthlink.net",
            "optonline.net", "freenet.de", "t-online.de", "aliceadsl.fr", "virgilio.it",
            "home.nl", "qq.com", "telenet.be", "me.com", "yahoo.com.ar",
            "tiscali.co.uk", "yahoo.com.mx", "voila.fr", "gmx.net", "mail.com",
            "planet.nl", "tin.it", "live.it", "ntlworld.com", "arcor.de",
            "yahoo.co.id", "frontiernet.net", "hetnet.nl", "live.com.au", "yahoo.com.sg",
            "zonnet.nl", "club-internet.fr", "juno.com", "optusnet.com.au", "blueyonder.co.uk",
            "bluewin.ch", "skynet.be", "sympatico.ca", "windstream.net", "mac.com",
            "centurytel.net", "chello.nl", "live.ca", "aim.com", "bigpond.net.au"
        ]
        let at = "@"
        let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
        
        if !email.contains(where: { punctuation.contains( $0 )}) {
            print("DEBUG PRINT: E-mail is not the correct entering")
            return .lacksPunctuation
            
        } else if !emailDomains.contains(emailDomains) {
            print("DEBUG PRINT: E-mail is entering wrong domain")
            return .invalidDomain
            
        } else if !email.contains(at) {
            print("DEBUG PRINT: E-mail is missing @")
            return .lackAt
            
        } else {
            print("DEBUG PRINT: E-mail is vaild")
            return .valid
        }
    }
    
    // MARK: - Actions:
    @objc func registerButtonTapped(_ sender: UIButton) {
        let enteredMail     = mailTextField.text ?? ""
        let enteredPassword = passwordTextField.text ?? ""

        let emailResult    = checkEmailCorrection(enteredMail)
        let passwordResult = checkPasswordCorrection(enteredPassword)

        if emailResult != .valid {
            switch emailResult {
            case .valid:
                enterEmailStatusLabel.isHidden = true
                print("DEBUG PRINT: 信箱輸入正確")
            case .lacksPunctuation:
                enterEmailStatusLabel.isHidden = false
                enterEmailStatusLabel.text = "信箱缺少特殊字元"
                print("DEBUG PRINT: 信箱輸入缺少特殊符號")
            case .lackAt:
                enterEmailStatusLabel.isHidden = false
                enterEmailStatusLabel.text = "信箱缺少@"
                print("DEBUG PRINT: 信箱輸入缺少@")
            case .invalidDomain:
                enterEmailStatusLabel.isHidden = false
                enterEmailStatusLabel.text = "信箱域名不正確"
                print("DEBUG PRINT: 信箱域名不正確")
            }
        } else if passwordResult != .valid {
            switch passwordResult {
            case .valid:
                enterPasswordStatusLabel.isHidden = true
                print("DEBUG PRINT: 密碼輸入正確")
            case .containsCommonPassword:
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "請修改密碼"
                print("DEBUG PRINT: 密碼設定太常見")
            case .lacksDigits:
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼缺少數字"
                print("DEBUG PRINT: 密碼缺少數字")
            case .lacksPunctuation:
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼缺少特殊字元"
                print("DEBUG PRINT: 密碼缺少特殊字元")
            case .lackTextLength:
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼字數不正確"
                print("DEBUG PRINT: 密碼字數不正確")
            case .empty:
                enterPasswordStatusLabel.isHidden = false
                enterPasswordStatusLabel.text = "密碼欄位不得空白"
                print("DEBUG PRINT: 密碼為空白")
            }
        } else {
            Auth.auth().createUser(withEmail: enteredMail, password: enteredPassword) { (authResult, error) in
                // Handle any errors during registration
                if let error = error {
                    AlertManager.showButtonAlert(on: self, title: "輸入錯誤", message: error.localizedDescription)
                    return
                }

                // Show activity indicator
                self.registerButton.configuration?.showsActivityIndicator = true
                
                // Registration successful, show success alert
                AlertManager.showButtonAlert(on: self, title: "註冊成功", message: "恭喜你，註冊成功!!!")
                
                // Present login view controller
                let loginVC = LoginViewController()
                self.present(loginVC, animated: true)
            }
        }
    }
}

// MARK: - Extension:
extension RegisterViewController: UITextFieldDelegate {
    // MARK: textField Should End Editing
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textField Should End Editing")
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: textField Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textField Should Return")
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: textField Did Begin Editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textField Did Begin Editing")
        textField.becomeFirstResponder()
    }
    
    // MARK: textField Did Change Selection
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
    UINavigationController(rootViewController: RegisterViewController())
}
