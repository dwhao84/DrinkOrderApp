//
//  LoginViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var userNameEntered: String?
    
    // MARK: - UIImageView:
    var logoImageView: UIImageView = {
        let logoImageView: UIImageView = UIImageView()
        logoImageView.image       = Images.kebukeLoginLogo
        logoImageView.contentMode = .scaleToFill
        return logoImageView
    } ()
    
    // MARK: - UITextField:
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
        enterNameTextField.clearButtonMode = .whileEditing
        enterNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return enterNameTextField
    } ()
    
    // MARK: - UIButton:
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
    
    // MARK: - UIStackView:
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
        
        print("Into the LoginVC")
        self.view.backgroundColor = Colors.kebukeDarkBlue
        setupUI()
        addTarget()
        addDelegate()
    }
    
    func addTarget () {
        loginButton.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
    }
    
    func addDelegate () {
        enterNameTextField.delegate = self
    }
    
    // MARK: - Actions
    @objc func loginBtnTapped (_ sender: UIButton) {
          guard let text = enterNameTextField.text, !text.isEmpty else {
              print("you didn't enter anything.")
              showMissingNameAC(title: "缺少姓名資料", message: "")
              return
          }
          
          let tabBarController = createTabBarController()
          tabBarController.modalPresentationStyle = .overFullScreen
          self.present(tabBarController, animated: true)
          print("DEBUG PRINT: loginBtnTapped")
      }
      
      @objc func registerBtnTapped (_ sender: UIButton) {
          let registerVC = RegisterViewController()
          registerVC.modalPresentationStyle = .popover
          self.present(registerVC, animated: true)
          print("DEBUG PRINT: registerBtnTapped")
      }
      
      // MARK: - Create multiple navigation controller:
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
        
        enterNameTextField.widthAnchor.constraint(equalToConstant: 280).isActive = true
        enterNameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        loginButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        registerButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let imageViewWidth: Double = 320
        logoImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: imageViewWidth * 0.7).isActive = true
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(enterNameTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
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
    UINavigationController(rootViewController: LoginViewController())
}
