//
//  OrderDetailViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/18.
//

import UIKit
import Kingfisher

class OrderDetailViewController: UIViewController {
    
    let cupSize: [String] = ["中杯 M", "大杯 L"]
    let sugarLevel: [String] = ["正常糖", "少糖", "半糖", "微糖", "二分糖", "一分糖", "無糖"]
    let iceLevel: [String] = ["正常冰", "少冰", "微冰", "去冰", "完全去冰", "常溫", "溫", "熱"]
    
    
    // MARK: - Passing Data:
    var drinksName: String?
    var drinksDescription: String?
    var drinksImageURL: String?
    
    
    // Show the product image at the top.
    let drinksImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.banner04
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.kebukeLightBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let drinkNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let drinkDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Drink Description Label"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // MARK: - Sugar Level
    let sugarLevelLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Sugar Level 糖量"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let sugarTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = ""
        textField.borderStyle = .roundedRect
        textField.isEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
        
    let sugarStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // MARK: - ice Level
    let iceLevelLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Ice Level 冰量"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let iceLevelPickerView: UIPickerView = UIPickerView()
    let sugarLevelPickerView: UIPickerView = UIPickerView()
    
    let iceTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.text = ""
        textField.borderStyle = .roundedRect
        textField.isEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    let iceStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
        
    var submitBtn: UIButton = {
        let btn: UIButton = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        
        var title = AttributedString("Submit")
        title.font = UIFont.boldSystemFont(ofSize: 20)
        config.attributedTitle = title
        config.cornerStyle = .large
        config.baseBackgroundColor = Colors.kebukeLightBlue
        config.titleAlignment = .center
        btn.configuration = config
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    } ()
    
    var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = Colors.kebukeLightBlue
        scrollView.showsHorizontalScrollIndicator = true
        return scrollView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        // Passing Data from HomePageVC:
        guard let url = drinksImageURL else {
            print("Unable to get drinksURL")
            return
        }
        
        drinkNameLabel.text        = drinksName
        drinkDescriptionLabel.text = drinksDescription
        let drinksImageUrl = URL(string: url)
        drinksImageView.kf.setImage(with: drinksImageUrl)
    }
    
    func setupUI () {
        self.view.backgroundColor = Colors.white
        setNavigationView()
        addSubviews()
        addConstraints()
        configStackView()
        addDelegateAndDataSource()
        addTargets()
        setupTextFields()
    }
    
    func addSubviews () {
        view.addSubview(drinksImageView)
        view.addSubview(submitBtn)
        view.addSubview(iceTextField)
        view.addSubview(iceLevelLabel)
        view.addSubview(sugarStackView)
        view.addSubview(iceStackView)
    }
    
    func addTargets () {
        submitBtn.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
    }
    
    func setupTextFields () {
        sugarTextField.inputView = sugarLevelPickerView
        iceTextField.inputView   = iceLevelPickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnTapped))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        sugarTextField.inputAccessoryView = toolBar
        iceTextField.inputAccessoryView = toolBar
    }
    
    func setNavigationView () {
        self.navigationItem.title = drinksName
        print("DEBUG PRINT: 印出產品名稱\(String(describing: drinksName))")
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeLightBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance   = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func addConstraints () {
        NSLayoutConstraint.activate([
            drinksImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            drinksImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drinksImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drinksImageView.heightAnchor.constraint(equalTo: drinksImageView.widthAnchor, multiplier: 0.75)
        ])
        
        NSLayoutConstraint.activate([
            submitBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            submitBtn.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        /// sugarStackView:
        NSLayoutConstraint.activate([
            sugarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sugarStackView.topAnchor.constraint(equalTo: drinksImageView.bottomAnchor, constant: 30),
            sugarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sugarTextField.widthAnchor.constraint(equalToConstant: 200),
            sugarTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            iceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iceStackView.topAnchor.constraint(equalTo: sugarStackView.bottomAnchor, constant: 30),
            iceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            iceTextField.widthAnchor.constraint(equalToConstant: 200),
            iceTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 60),
        ])
    }
    
    func configStackView () {
        sugarStackView.addArrangedSubview(sugarLevelLabel)
        sugarStackView.addArrangedSubview(sugarTextField)
        iceStackView.addArrangedSubview(iceLevelLabel)
        iceStackView.addArrangedSubview(iceTextField)
    }
    
    func addDelegateAndDataSource () {
        iceTextField.delegate = self
        sugarTextField.delegate = self
        
        iceLevelPickerView.delegate = self
        iceLevelPickerView.dataSource = self
        sugarLevelPickerView.delegate = self
        sugarLevelPickerView.dataSource = self
    }
    
    
    @objc func submitBtnTapped (_ sender: UIButton) {
        print("sumbit btn tapped")
    }
    
    @objc func cancelBtnTapped (_ sender: UIBarButtonItem) {
        print("cancelBtnTapped")
        sugarTextField.resignFirstResponder()
        iceTextField.resignFirstResponder()
    }
    
    @objc func doneBtnTapped (_ sender: UIBarButtonItem) {
        print("doneBtnTapped")
        sugarTextField.resignFirstResponder()
        iceTextField.resignFirstResponder()
    }
}

extension OrderDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension OrderDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        iceLevelPickerView.resignFirstResponder()
        sugarLevelPickerView.resignFirstResponder()
        return true
    }
}

extension OrderDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == iceLevelPickerView) {
            print(iceLevel.count)
            return iceLevel.count
        } else {
            print(sugarLevel.count)
            return sugarLevel.count
        }
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == iceLevelPickerView) {
            iceTextField.text = iceLevel[row]
            iceLevelPickerView.resignFirstResponder()
        } else {
            sugarTextField.text = sugarLevel[row]
            sugarLevelPickerView.resignFirstResponder()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == iceLevelPickerView) {
            print(iceLevel.count)
            return iceLevel[row]
        } else {
            print(sugarLevel.count)
            return sugarLevel[row]
        }
    }
}

#Preview {
    UINavigationController(rootViewController: OrderDetailViewController())
}
