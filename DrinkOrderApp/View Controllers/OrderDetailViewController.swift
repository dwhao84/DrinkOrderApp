//
//  OrderDetailViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/18.
//

import UIKit
import Kingfisher

class OrderDetailViewController: UIViewController {
    
    static let shared: String = "OrderDetailViewController"
    
    let cupSize: [String]    = ["中杯 M", "大杯 L"]
    let sugarLevel: [String] = ["正常糖", "少糖", "半糖", "微糖", "二分糖", "一分糖", "無糖"]
    let iceLevel: [String]   = ["正常冰", "少冰", "微冰", "去冰", "完全去冰", "常溫", "溫", "熱"]
    let toppingChoose: [String] = ["不用配料", "加白玉 +10", "加菓玉 +10", "加水玉 +10"]
    
    // MARK: - Passing Datas:
    var drinksName: String?
    var drinksDescription: String?
    var drinksImageURL: String?
    
    // Show the product image at the top.
    let drinksImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.banner04
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.tintColor = Colors.kebukeLightBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let drinkNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Drink Name Label"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let drinkDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Drink Description Label"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = Colors.kebukeBrown
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // MARK: - Custom Labels
    let cupSizeLabel: CustomOrderDetailLabel = {
        let label: CustomOrderDetailLabel = CustomOrderDetailLabel()
        label.text = "請選擇尺寸"
        return label
    } ()
    
    let iceLevelLabel: CustomOrderDetailLabel = {
        let label: CustomOrderDetailLabel = CustomOrderDetailLabel()
        label.text = "請選擇冰塊"
        return label
    } ()
    
    let sugarLevelLabel: CustomOrderDetailLabel = {
        let label: CustomOrderDetailLabel = CustomOrderDetailLabel()
        label.text = "請選擇甜度"
        return label
    } ()
    
    let toppingLevelLabel: CustomOrderDetailLabel = {
        let label: CustomOrderDetailLabel = CustomOrderDetailLabel()
        label.text = "請選擇加料"
        return label
    } ()
    
    // MARK: - Custom TextFields
    let cupSizeTextField: CustomTextField = {
        let textField: CustomTextField = CustomTextField()
        textField.text = "尺寸選擇"
        return textField
    } ()
    
    let sugarLevelTextField: CustomTextField = {
        let textField: CustomTextField = CustomTextField()
        textField.text = "甜度選擇"
        return textField
    } ()
    
    let iceLevelTextField: CustomTextField = {
        let textField: CustomTextField = CustomTextField()
        textField.text = "請選擇冰塊"
        return textField
    } ()
    
    let toppingTextField: CustomTextField = {
        let textField: CustomTextField = CustomTextField()
        textField.text = "加料選擇"
        return textField
    } ()

    let drinksQtyStepper: DrinksQtyStepper = {
        let stepper: DrinksQtyStepper = DrinksQtyStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    } ()
    
    // MARK: - Custom StackViews
    let drinksInfoStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let cupSizeStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let iceLevelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let sugarLevelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let toppingChooseStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // MARK: - Custom Button:
    var submitBtn: SubmitButton = {
        let btn: SubmitButton = SubmitButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    } ()
    
    // MARK: - PickerViews:
    let cupSizePickerView: UIPickerView = UIPickerView()
    let iceLevelPickerView: UIPickerView = UIPickerView()
    let sugarLevelPickerView: UIPickerView = UIPickerView()
    let toppingPickerView: UIPickerView = UIPickerView()
    
    // MARK: - Life Cycle:
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
        
        sugarLevelTextField.text = sugarLevel[0]
        iceLevelTextField.text   = iceLevel[0]
        toppingTextField.text    = toppingChoose[0]
    }
    
    // MARK: - Set up UI.
    func setupUI () {
        self.view.backgroundColor = Colors.white
        setNavigationView()
        addConstraints()
        configStackView()
        addDelegateAndDataSource()
        addTargets()
        setupTextFields()
        
        // tabBar is hidden.
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Add targets
    func addTargets () {
        submitBtn.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
    }
    
    func setupTextFields () {
        let toolBar: UIToolbar = UIToolbar()
        let toolAppearance = UIToolbarAppearance()
        toolBar.standardAppearance = toolAppearance
        toolBar.scrollEdgeAppearance = toolAppearance
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.isUserInteractionEnabled = true
        toolBar.layer.cornerRadius = 20
        toolBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        toolBar.layer.masksToBounds = true
        toolBar.sizeToFit()
        toolBar.layer.borderColor = Colors.lightGray.cgColor
        toolBar.layer.borderWidth = 0.2
        
        // FIXME: - Auto Layout 有些問題
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        cupSizeTextField.inputAccessoryView = toolBar
        sugarLevelTextField.inputAccessoryView = toolBar
        iceLevelTextField.inputAccessoryView = toolBar
        toppingTextField.inputAccessoryView = toolBar
        
        cupSizeTextField.inputView = cupSizePickerView
        sugarLevelTextField.inputView = sugarLevelPickerView
        iceLevelTextField.inputView   = iceLevelPickerView
        toppingTextField.inputView = toppingPickerView
    }
    
    // MARK: - Setup NavigationView:
    func setNavigationView () {
        self.navigationItem.title = drinksName
        print("DEBUG PRINT: 印出產品名稱\(String(describing: drinksName))")
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeLightBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance   = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Add Constraints:
    func addConstraints () {
        view.addSubview(drinksImageView)
        view.addSubview(drinksInfoStackView)
        
        view.addSubview(cupSizeStackView)
        view.addSubview(iceLevelStackView)
        view.addSubview(sugarLevelStackView)
        view.addSubview(toppingChooseStackView)
        view.addSubview(submitBtn)
        view.addSubview(mainStackView)
        
        // drinksImageView:
        NSLayoutConstraint.activate([
            drinksImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            drinksImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            drinksImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            drinksImageView.heightAnchor.constraint(equalTo: drinksImageView.widthAnchor, multiplier: 0.75)
        ])
        
        // SubmitButton:
        NSLayoutConstraint.activate([
            submitBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            submitBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // drinksInfoStackView
        NSLayoutConstraint.activate([
            drinksInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            drinksInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            drinksInfoStackView.topAnchor.constraint(equalTo: drinksImageView.bottomAnchor, constant: 20)
        ])
        
        // mainStackView
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainStackView.topAnchor.constraint(equalTo: drinksInfoStackView.bottomAnchor, constant: 20)
        ])
        
    }
    
    func configStackView () {
        cupSizeTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 210).isActive = true
        cupSizeTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        iceLevelTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 210).isActive = true
        iceLevelTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        sugarLevelTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 210).isActive = true
        sugarLevelTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        toppingTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 210).isActive = true
        toppingTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        cupSizeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        iceLevelLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        sugarLevelLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        toppingLevelLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        
        // StackView:
        drinksInfoStackView.addArrangedSubview(drinkNameLabel)
        drinksInfoStackView.addArrangedSubview(drinkDescriptionLabel)
        
        cupSizeStackView.addArrangedSubview(cupSizeLabel)
        cupSizeStackView.addArrangedSubview(cupSizeTextField)
        
        iceLevelStackView.addArrangedSubview(iceLevelLabel)
        iceLevelStackView.addArrangedSubview(iceLevelTextField)
        
        sugarLevelStackView.addArrangedSubview(sugarLevelLabel)
        sugarLevelStackView.addArrangedSubview(sugarLevelTextField)
        
        toppingChooseStackView.addArrangedSubview(toppingLevelLabel)
        toppingChooseStackView.addArrangedSubview(toppingTextField)
        
        mainStackView.addArrangedSubview(cupSizeStackView)
        mainStackView.addArrangedSubview(iceLevelStackView)
        mainStackView.addArrangedSubview(sugarLevelStackView)
        mainStackView.addArrangedSubview(toppingChooseStackView)
        mainStackView.addArrangedSubview(drinksQtyStepper)
    }
    
    func addDelegateAndDataSource () {
        // PickerViews:
        cupSizePickerView.delegate = self
        cupSizePickerView.dataSource = self
        
        iceLevelPickerView.delegate = self
        iceLevelPickerView.dataSource = self
        
        sugarLevelPickerView.delegate = self
        sugarLevelPickerView.dataSource = self
        
        toppingPickerView.delegate = self
        toppingPickerView.dataSource = self
        
        // TextFields:
        cupSizeTextField.delegate = self
        iceLevelTextField.delegate = self
        sugarLevelTextField.delegate = self
        toppingTextField.delegate = self
    }
    
    func showAlertVC (title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        controller.addAction(okAction)
        present(controller, animated: true)
    }
    
    // MARK: - Actions
    @objc func submitBtnTapped (_ sender: UIButton) {
        
        let selectionStatus: [String] = ["尺寸選擇", "請選擇冰塊", "甜度選擇", "加料選擇"]
        let selectionStatusContent: [String] = ["請選擇飲料尺寸", "請選擇飲料冰塊", "請選擇飲料甜度", "請選擇飲料加料內容"]
        
        print("DEBUG PRINT: sumbit btn tapped")
        
        // 當textField.text 為 尺寸選擇，則跳出alertVC.
        if cupSizeTextField.text == selectionStatus[0] {
            print("DEBUG PRINT: 尚未選擇飲料尺寸")
            showAlertVC(title: selectionStatusContent[0], message: selectionStatusContent[0])
            
        // 當textField.text 為 請選擇冰塊，則跳出alertVC.
        } else if iceLevelTextField.text == selectionStatus[1] {
            print("DEBUG PRINT: 尚未選擇飲料冰塊")
            showAlertVC(title: selectionStatusContent[1], message: selectionStatusContent[1])
            
        // 當textField.text 為 甜度選擇，則跳出alertVC.
        } else if sugarLevelTextField.text == selectionStatus[2] {
            print("DEBUG PRINT: 尚未選擇飲料甜度")
            showAlertVC(title: selectionStatusContent[2], message: selectionStatusContent[2])
        
        // 當textField.text 為 加料選擇，則跳出alertVC.
        } else if toppingTextField.text == selectionStatus[3] {
            print("DEBUG PRINT: 尚未選擇飲料加料內容")
            showAlertVC(title: selectionStatusContent[3], message: selectionStatus[3])
            
        } else {
            print("DEBUG PRINT: 飲料內容選擇完畢，將頁面傳送OrderListVC")
            let orderListVC = OrderListViewController()
            self.navigationController?.pushViewController(orderListVC, animated: true)
        }
    }
    
    @objc func cancelBtnTapped (_ sender: UIBarButtonItem) {
        print("cancelBtnTapped")
        cupSizeTextField.resignFirstResponder()
        sugarLevelTextField.resignFirstResponder()
        iceLevelTextField.resignFirstResponder()
        toppingTextField.resignFirstResponder()
    }
    
    @objc func doneBtnTapped (_ sender: UIBarButtonItem) {
        print("doneBtnTapped")
        cupSizeTextField.resignFirstResponder()
        sugarLevelTextField.resignFirstResponder()
        iceLevelTextField.resignFirstResponder()
        toppingTextField.resignFirstResponder()
    }
}

extension OrderDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ( textField == cupSizeTextField ) {
            textField.resignFirstResponder()
            cupSizePickerView.isHidden = true
            
        } else if ( textField == iceLevelTextField ) {
            textField.resignFirstResponder()
            iceLevelPickerView.isHidden = true
            
        } else if ( textField == sugarLevelTextField ) {
            textField.resignFirstResponder()
            sugarLevelPickerView.isHidden = true
            
        } else if ( textField == toppingTextField ) {
            textField.resignFirstResponder()
            toppingPickerView.isHidden = true
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if ( textField == cupSizeTextField ) {
            textField.resignFirstResponder()
            
        } else if ( textField == iceLevelTextField ) {
            textField.resignFirstResponder()
            
        } else if ( textField == sugarLevelTextField ) {
            textField.resignFirstResponder()
            
        } else if ( textField == toppingTextField ) {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if ( textField == cupSizeTextField ) {
            print(cupSizeTextField.text ?? "Unable to get cupSizeTextField's text")
            
        } else if ( textField == iceLevelTextField ) {
            print(iceLevelTextField.text ?? "Unable to get iceLevelTextField's text")
            
        } else if ( textField == sugarLevelTextField ) {
            print(sugarLevelTextField.text ?? "Unable to get sugarLevelTextField's text")
            
        } else if ( textField == toppingTextField ) {
            print(toppingTextField.text ?? "Unable to get toppingTextField's text")
        }
    }
}

extension OrderDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if ( pickerView == cupSizePickerView ) {
            print("cupSize.count equals \(cupSize.count)")
            return cupSize.count
            
        } else if (pickerView == iceLevelPickerView) {
            print("iceLevel.count equals \(iceLevel.count)")
            return iceLevel.count
            
        } else if (pickerView == sugarLevelPickerView) {
            print("sugarLevel.count equals \(sugarLevel.count)")
            return sugarLevel.count
            
        } else if (pickerView == toppingPickerView) {
            print("toppingChoose.count equals \(toppingChoose.count)")
            return toppingChoose.count
            
        } else {
            return 1
        }
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == cupSizePickerView ) {
            cupSizeTextField.text = cupSize[row]
            print("\(String(describing: cupSizeTextField.text))")
            cupSizePickerView.resignFirstResponder()
            
        } else if (pickerView == iceLevelPickerView) {
            iceLevelTextField.text = iceLevel[row]
            print("\(String(describing: iceLevelTextField.text))")
            iceLevelPickerView.resignFirstResponder()
            
        } else if (pickerView == sugarLevelPickerView) {
            sugarLevelTextField.text = sugarLevel[row]
            print("\(String(describing: sugarLevelTextField.text))")
            sugarLevelPickerView.resignFirstResponder()
            
        } else if (pickerView == toppingPickerView) {
            toppingTextField.text = toppingChoose[row]
            print("\(String(describing: toppingTextField.text))")
            toppingPickerView.resignFirstResponder()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == cupSizePickerView {
            print("切換到 尺寸PickerView")
            return cupSize[row]
            
        } else if (pickerView == iceLevelPickerView) {
            print("切換到 冰塊 PickerView")
            return iceLevel[row]
            
        } else if (pickerView == sugarLevelPickerView) {
            print("切換到 甜度 PickerView")
            return sugarLevel[row]
            
        } else if (pickerView == toppingPickerView) {
            print("切換到 加料 PickerView")
            return toppingChoose[row]
        }
        return String()
    }
}

#Preview {
    UINavigationController(rootViewController: OrderDetailViewController())
}
