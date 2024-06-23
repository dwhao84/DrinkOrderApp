//
//  RegisterViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit

class RegisterViewController: UIViewController {
    
    enum  Condition {
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
    
    // MARK: - Check Name correction
    func checkNameCorrection (_ userName: String) -> NameCheck {
        let textLength = Int(nameTextField.text?.count ?? 0)
        
        if textLength < 1 && textLength > 10 {
            print("""
                   DEBUG PRINT: User Name's text length is not correct
                   \(textLength)
                """)
            return .lackTextlength
        } else if textLength == 0 {
            print("DEBUG PRINT: User name is empty")
            return .empty
        } else {
            print("DEBUG PRINT: User name is valid")
            return .valid
        }
    }
    
    // MARK: - Check Password correction
    func checkPasswordCorrection(_ password: String) -> PasswordCheck {
        let tenCommonPasswords = ["123456", "123456789", "qwerty", "password", "12345678", "111111", "iloveyou", "1q2w3e", "123123", "password1"]
        let digits = "0123456789"
        let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
        let textLength = Int(passwordTextField.text?.count ?? 0)
        
        if tenCommonPasswords.contains(password) {
            print("DEBUG PRINT: Using ten common passwords")
            return .containsCommonPassword
            
        } else if textLength == 0 {
            print("DEBUG PRINT: Password is empty")
            return .empty
            
        } else if !password.contains(where: { digits.contains($0) }) {
            print("DEBUG PRINT: Password is missing digits")
            return .lacksDigits
            
        } else if !password.contains(where: { punctuation.contains($0) }) {
            print("DEBUG PRINT: Password is uncorrect")
            return.lacksPunctuation
            
        } else if textLength > 16 && textLength < 9 {
            
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
            return .valid }
    }
    
    // MARK: - Action:
    @objc func registerButtonTapped(_ sender: UIButton)  {
        let enteredName = nameTextField.text ?? ""
        let enteredMail = mailTextField.text ?? ""
        let enteredPassword = passwordTextField.text ?? ""
        
        let nameResult = checkNameCorrection(enteredName)
        let emailResult = checkEmailCorrection(enteredMail)
        let passwordResult = checkPasswordCorrection(enteredPassword)
        
        
        
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true)
        
        
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
        print("textField Should End Editing")
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
