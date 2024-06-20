//
//  LoginViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - UIImageView:
    private let logoImageView: UIImageView = {
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image       = Images.kebukeLoginLogo
        logoImageView.contentMode = .scaleToFill
        return logoImageView
    } ()
    
    // MARK: - UITextFields:
    private let accountTextField: AccountTextField = {
        let accountTextField: AccountTextField = AccountTextField()
        return accountTextField
    } ()
    
    private let passwordTextField: PasswordTextField = {
        let accountTextField: PasswordTextField = PasswordTextField()
        return accountTextField
    } ()
    
    // MARK: - UIButton:
    // loginButton
    private let loginButton: LoginButton = {
        let button = LoginButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // MARK: - UIStackView:
    // stackView
    private let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis             = .vertical
        stackView.alignment        = .center
        stackView.spacing          = 25
        stackView.distribution     = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
        
    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Into the LoginVC")
        self.view.backgroundColor = Colors.kebukeDarkBlue
        setupUI()
        addTargets()
        addDelegates()
    }
    
    // MARK: - Add Targets
    func addTargets () {
        loginButton.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
    }
    
    func addDelegates () {
        accountTextField.delegate  = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Actions
      @objc func loginBtnTapped (_ sender: UIButton) {
          let tabBarController = createTabBarController()
          tabBarController.modalPresentationStyle = .overFullScreen
          self.present(tabBarController, animated: true)
          print("DEBUG PRINT: registerBtnTapped")
      }
      
      // MARK: - Create multiple navigation controller for tabBarController:
      func createTheHomePageNavigationVC () -> UINavigationController {
          let homePageVC              = HomePageViewController()
          let homePageNC              = UINavigationController(rootViewController: homePageVC)
          homePageNC.tabBarItem.image = Images.homePage
          homePageNC.tabBarItem.title = "Home"
          return homePageNC
      }
      
      func createTheOrderListNavigationVC () -> UINavigationController {
          let orderListVC              = OrderListViewController()
          let orderListNC              = UINavigationController(rootViewController: orderListVC)
          orderListNC.tabBarItem.image = Images.cart
          orderListNC.tabBarItem.title = "List"
          return orderListNC
      }
      
      func createTheSettingTableViewNavigationVC () -> UINavigationController {
          let settingTableVC           = SettingTableViewController()
          let settingTableNC           = UINavigationController(rootViewController: settingTableVC)
          settingTableNC.tabBarItem.image = Images.setting
          settingTableNC.tabBarItem.title = "Setting"
          return settingTableNC
      }
      
      func createTabBarController () -> UITabBarController {
          let tabBarController                  = UITabBarController()
          tabBarController.tabBar.barTintColor  = Colors.white
          tabBarController.viewControllers      = [
              createTheHomePageNavigationVC        (),
              createTheOrderListNavigationVC       ()
          ]
          tabBarController.tabBar.tintColor     = Colors.kebukeBrown
          tabBarController.tabBar.isTranslucent = true
          let standardAppearance = UITabBarAppearance()
          tabBarController.tabBar.standardAppearance = standardAppearance
          tabBarController.tabBar.scrollEdgeAppearance = standardAppearance
          return tabBarController
      }
    
    // MARK: - Setup UI:
    func setupUI() {
        loginButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 180).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        accountTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 120).isActive = true
        accountTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 120).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let imageViewWidth: Double = self.view.bounds.width - 100.0
        logoImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: imageViewWidth * 0.7).isActive = true
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(accountTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: - Show Alert Controller:
    func showMissingNameAC (title: String, message: String) {
        let controller = UIAlertController(
            title: """
            缺少姓名資料
            """,
            message: "",
            preferredStyle: .alert
        )
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK: - Extenstion:
extension LoginViewController: UITextFieldDelegate {
    // MARK: - textField Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("DEBUG PRINT: textFieldShouldReturn")
        
        if textField.text == "" {
            print("DEBUG PRINT: textField is empty.")
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - textField Did Change Selection
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == accountTextField {
            print("""
                  DEBUG PRINT: textField Did Change Selection
                  \(textField.text ?? "accountTextField Did Change")
                  """)
        } else if textField == passwordTextField {
            print("""
                  DEBUG PRINT: textField Did Change Selection
                  \(textField.text ?? "passwordTextField Did Change")
                  """)
        }
    }
    
    // MARK: - textField Did Begin Editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        print("textField Did Begin Editing")
    }
    
    // MARK: - textField Did End Editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        print("textField Did End Editing")
    }
}

#Preview {
    UINavigationController(rootViewController: LoginViewController())
}
