//
//  RegisterViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit

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
    // name TextField:
    var nameTextField: UITextField = {
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
    
    // mail TextField:
    var mailTextField: UITextField = {
        let enterNameTextField: UITextField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "Enter your mail",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.kebukeBrown]
        )
        enterNameTextField.attributedPlaceholder = attributedPlaceholder
        enterNameTextField.borderStyle      = .roundedRect
        enterNameTextField.textColor        = Colors.darkGray
        enterNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return enterNameTextField
    } ()
    
    // password TextField:
    var passwordTextField: UITextField = {
        let enterNameTextField: UITextField = UITextField()
        let attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.kebukeBrown]
        )
        enterNameTextField.attributedPlaceholder = attributedPlaceholder
        enterNameTextField.borderStyle      = .roundedRect
        enterNameTextField.textColor        = Colors.darkGray
        enterNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return enterNameTextField
    } ()
    
    // Register Button:
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
    
    @objc func registerButtonTapped () {
        print("registerButtonTapped")
        
        showSucessfulAlert()
    }
    
    func showSucessfulAlert () {
        let controller = UIAlertController(title: "Register Success", message: "", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(controller, animated: true, completion: nil)
    }
    
}

#Preview {
    let registerVC = RegisterViewController()
    return registerVC
}
