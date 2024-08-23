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
    
    var drinksQty: Int = 0
    
    // MARK: - PickerView Selection Content.
    let cupSize: [String]    = ["中杯 M", "大杯 L"]
    let sugarLevel: [String] = ["正常糖", "少糖", "半糖", "微糖", "二分糖", "一分糖", "無糖"]
    let iceLevel: [String]   = ["正常冰", "少冰", "微冰", "去冰", "完全去冰", "常溫", "溫", "熱"]
    let toppingChoose: [String] = ["不用配料", "加白玉 +10", "加菓玉 +10", "加水玉 +10"]
    
    // MARK: - PicketView Content:
    let selectionStatus: [String] = ["尺寸選擇", "請選擇冰塊", "甜度選擇", "加料選擇"]
    let selectionStatusContent: [String] = ["請選擇飲料尺寸", "請選擇飲料冰塊", "請選擇飲料甜度", "請選擇飲料加料內容"]
    
    // MARK: - Passing Datas:
    var userName: String?
    var drinksName: String?
    var drinksDescription: String?
    var drinksImageURL: String?
    var drinksMediumPrice: Int?
    var drinksLargePrice: Int?
    
    // MARK: - Show the product image at the top.
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
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Colors.kebukeBrown
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // MARK: - Custom Labels
    let userNameLabel: CustomOrderDetailLabel = {
        let label: CustomOrderDetailLabel = CustomOrderDetailLabel()
        label.text = "填入姓名    "
        return label
    } ()
    
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
    
    // Show drinks medium / large price
    var drinksPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = Colors.darkGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let drinkOrderQty: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // MARK: - Custom TextFields
    let userNameTextField: CustomTextField = {
        let textField: CustomTextField = CustomTextField()
        textField.text = "填入姓名"
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = .whileEditing
        return textField
    } ()
    
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

    let drinkStepper: UIStepper = {
        let stepper: UIStepper = UIStepper()
        stepper.value = 1
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.overrideUserInterfaceStyle = .light
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    } ()
    
    // MARK: - Custom StackViews
    let drinksContentStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let drinksInfoStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let userNameStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
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
    
    let secondStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let horizontalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // MARK: - ScrollView
    let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    } ()
    
    // MARK: -  Button:
    let submitBtn: SubmitButton = {
        let btn: SubmitButton = SubmitButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    } ()
    
    let doneBtn: DoneButton = {
        let btn: DoneButton = DoneButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    } ()
    
    let cancelBtn: CancelButton = {
        let btn: CancelButton = CancelButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    } ()

    
    // MARK: - PickerViews:
    let cupSizePickerView: UIPickerView    = UIPickerView()
    let iceLevelPickerView: UIPickerView   = UIPickerView()
    let sugarLevelPickerView: UIPickerView = UIPickerView()
    let toppingPickerView: UIPickerView    = UIPickerView()

    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()

        // MARK: Passing Data from HomePageVC:
        guard let url = drinksImageURL else {
            print("Unable to get drinksURL")
            return
        }
        
        drinkNameLabel.text        = drinksName
        drinkDescriptionLabel.text = drinksDescription
        drinksPriceLabel.text = "$ \(drinksMediumPrice ?? 0)"
        let drinksImageUrl = URL(string: url)
        drinksImageView.kf.setImage(with: drinksImageUrl)
        
        sugarLevelTextField.text = sugarLevel[0]
        iceLevelTextField.text   = iceLevel[0]
        toppingTextField.text    = toppingChoose[0]
        userNameTextField.text   = "填入姓名"
        
    }
    
    // MARK: - Using  viewWillAppear to Make sure the tabBar is hidding.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Set up UI.
    func setupUI () {
        self.view.backgroundColor = Colors.white
        drinkOrderQty.text = "\(Int(drinkStepper.value))"
        setNavigationView()
        addConstraints()
        configStackView()
        addDelegateAndDataSource()
        addTargets()
        setupToolBarAndTextFields()
        addTapGesture()
        
        // tabBar is hidden.
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Add targets
    func addTargets () {
        submitBtn.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        doneBtn.addTarget(self, action: #selector(doneBtnTapped), for: .touchUpInside)
        drinkStepper.addTarget(self, action: #selector(stepperValueChanged), for: .touchUpInside)
    }
    
    // MARK: Set up ToolBar and Text Fields
    func setupToolBarAndTextFields () {
        let toolBar: UIToolbar = UIToolbar()
        let toolAppearance = UIToolbarAppearance()
        toolBar.standardAppearance = toolAppearance
        toolBar.scrollEdgeAppearance = toolAppearance
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30)
        toolBar.layer.cornerRadius = 20
        toolBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        toolBar.layer.masksToBounds = true
        toolBar.sizeToFit()
        toolBar.layer.borderColor = Colors.lightGray.cgColor
        toolBar.layer.borderWidth = 0.2
        toolBar.tintColor = Colors.kebukeLightBlue
        
        let doneButton = UIBarButtonItem(customView: doneBtn)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(customView: cancelBtn)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        cupSizeTextField.inputAccessoryView    = toolBar
        sugarLevelTextField.inputAccessoryView = toolBar
        iceLevelTextField.inputAccessoryView   = toolBar
        toppingTextField.inputAccessoryView    = toolBar
        
        cupSizeTextField.inputView    = cupSizePickerView
        sugarLevelTextField.inputView = sugarLevelPickerView
        iceLevelTextField.inputView   = iceLevelPickerView
        toppingTextField.inputView    = toppingPickerView
    }
    
    // MARK: - Setup NavigationView:
    func setNavigationView () {
        // Add custom Label for navigationView.
        let customLabel: UILabel = UILabel()
        customLabel.text = drinksName
        customLabel.font = UIFont.boldSystemFont(ofSize: 20)
        customLabel.textColor = Colors.white
        
        self.navigationItem.titleView = customLabel
        print("DEBUG PRINT: 印出產品名稱\(String(describing: drinksName))")
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.kebukeLightBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance   = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Add Constraints:
    func addConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
        ])
    }
    
    // MARK: Config stackView
    func configStackView () {
        let customWidth: CGFloat =  self.view.bounds.width - 60
        let customMultiplier: CGFloat = 0.75
        let customStackViewWidth: CGFloat = self.view.bounds.width - 80
        
        drinksImageView.widthAnchor.constraint(equalToConstant: customWidth).isActive = true
        drinksImageView.heightAnchor.constraint(equalTo: drinksImageView.widthAnchor, multiplier: customMultiplier).isActive = true
        
        submitBtn.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 80).isActive = true
        submitBtn.heightAnchor.constraint(equalTo: submitBtn.widthAnchor, multiplier: 0.15).isActive = true

        [userNameTextField,
         cupSizeTextField,
         iceLevelTextField,
         sugarLevelTextField,
         toppingTextField
        ].forEach {
            $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
            $0.widthAnchor.constraint(greaterThanOrEqualToConstant: 230).isActive = true
        }
        
        [cupSizeLabel,
         iceLevelLabel,
         sugarLevelLabel,
         toppingLevelLabel
        ].forEach {
            $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        }
        
        drinksPriceLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        // StackView:
        drinksInfoStackView.addArrangedSubview(drinkNameLabel)
        drinksInfoStackView.addArrangedSubview(drinkDescriptionLabel)
        
        /// questions & answers stackView
        userNameStackView.addArrangedSubview(userNameLabel)
        userNameStackView.addArrangedSubview(userNameTextField)
        
        cupSizeStackView.addArrangedSubview(cupSizeLabel)
        cupSizeStackView.addArrangedSubview(cupSizeTextField)
        
        iceLevelStackView.addArrangedSubview(iceLevelLabel)
        iceLevelStackView.addArrangedSubview(iceLevelTextField)
        
        sugarLevelStackView.addArrangedSubview(sugarLevelLabel)
        sugarLevelStackView.addArrangedSubview(sugarLevelTextField)
        
        toppingChooseStackView.addArrangedSubview(toppingLevelLabel)
        toppingChooseStackView.addArrangedSubview(toppingTextField)
        
        horizontalStackView.addArrangedSubview(drinkStepper)
        horizontalStackView.addArrangedSubview(drinkOrderQty)
        horizontalStackView.addArrangedSubview(drinksPriceLabel)
        
        [userNameStackView,
        cupSizeStackView,
        iceLevelStackView,
        toppingChooseStackView,
         horizontalStackView].forEach {
            $0.widthAnchor.constraint(equalToConstant: customStackViewWidth).isActive = true
        }
        
        /// secondStackView
        secondStackView.addArrangedSubview(drinksInfoStackView)
        secondStackView.addArrangedSubview(userNameStackView)
        secondStackView.addArrangedSubview(cupSizeStackView)
        secondStackView.addArrangedSubview(iceLevelStackView)
        secondStackView.addArrangedSubview(sugarLevelStackView)
        secondStackView.addArrangedSubview(toppingChooseStackView)
        secondStackView.addArrangedSubview(horizontalStackView)

        mainStackView.addArrangedSubview(drinksImageView)
        mainStackView.addArrangedSubview(secondStackView)
        mainStackView.addArrangedSubview(submitBtn)
    }
    
    // MARK: Add delegate and date source
    func addDelegateAndDataSource() {
        // PickerViews:
        let pickerViews: [UIPickerView] = [cupSizePickerView, iceLevelPickerView, sugarLevelPickerView, toppingPickerView]
        pickerViews.forEach { pickerView in
            pickerView.delegate = self
            pickerView.dataSource = self
        }
        
        // TextFields:
        let textFields: [UITextField] = [cupSizeTextField, iceLevelTextField, sugarLevelTextField, toppingTextField]
        textFields.forEach { textField in
            textField.delegate = self
        }
    }

    // MARK: - Tap Gesture
    func addTapGesture () {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    @objc func submitBtnTapped(_ sender: UIButton) {
        print("DEBUG PRINT: submit btn tapped")
        
        if cupSizeTextField.text == selectionStatus[0] {
            print("DEBUG PRINT: 尚未選擇飲料尺寸")
            AlertManager.showButtonAlert(on: self, title: selectionStatusContent[0], message: selectionStatusContent[0])
            
        } else if iceLevelTextField.text == selectionStatus[1] {
            print("DEBUG PRINT: 尚未選擇飲料冰塊")
            AlertManager.showButtonAlert(on: self, title: selectionStatusContent[1], message: selectionStatusContent[1])
            
        } else if sugarLevelTextField.text == selectionStatus[2] {
            print("DEBUG PRINT: 尚未選擇飲料甜度")
            AlertManager.showButtonAlert(on: self, title: selectionStatusContent[2], message: selectionStatusContent[2])
            
            
        } else if toppingTextField.text == selectionStatus[3] {
            print("DEBUG PRINT: 尚未選擇飲料加料內容")
            AlertManager.showButtonAlert(on: self, title: selectionStatusContent[3], message: selectionStatusContent[3])
            
        } else if userNameTextField.text == "填入姓名" || userNameTextField.text == "" {
            print("DEBUG PRINT: 記得填入姓名，不然彼得不會幫你付錢")
            AlertManager.showButtonAlert(on: self, title: "記得填入姓名", message: "記得填入姓名，不然彼得不會幫你付錢")
            
        } else {
            print("DEBUG PRINT: 飲料內容選擇完畢，將頁面傳送OrderListVC")
            
            let orderFields = OrderFields(
                userName: userNameTextField.text ?? "No User name",
                drinkName: drinksName ?? "No drinks name",
                cupSize: cupSizeTextField.text ?? "No Cup size",
                sugarLevel: sugarLevelTextField.text ?? "No Sugar Level",
                iceLevel: iceLevelTextField.text ?? "No Ice Level",
                topping: toppingTextField.text ?? "No Topping",
                qty: "\(Int(drinkStepper.value))",
                price: drinksPriceLabel.text ?? "No Price", 
                url: drinksImageURL
            )
            
            let newOrder = Order(fields: orderFields)
            NetworkManager.shared.postOrdersData(order: newOrder) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        AlertManager.showButtonAlert(on: self, title: "訂單建立成功!", message: "已經新增訂單!")
                        let orderListVC = OrderListViewController()
                        self.navigationController?.pushViewController(orderListVC, animated: true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        AlertManager.showButtonAlert(on: self, title: "訂單尚未建立!", message: "是不是忘了什麼!")
                        print("\(error.localizedDescription)")
                        self.submitBtn.configuration?.showsActivityIndicator = false
                    }
                }
            }
        }
    }
    
    @objc func cancelBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: cancel Btn Tapped")
        let textFields = [cupSizeTextField, sugarLevelTextField, iceLevelTextField, toppingTextField]
        textFields.forEach { $0.resignFirstResponder() }
    }
    
    @objc func doneBtnTapped(_ sender: UIButton) {
        print("DEBUG PRINT: done Btn Tapped")
        let textFields = [cupSizeTextField, sugarLevelTextField, iceLevelTextField, toppingTextField]
        textFields.forEach { $0.resignFirstResponder() }
    }

    
    @objc func viewTapped (_ sender: UITapGestureRecognizer) {
        print("view Tapped")
        self.view.endEditing(true)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        let cupSizeText = cupSizeTextField.text
        let toppingText = toppingTextField.text
        drinksQty = Int(drinkStepper.value)
        drinkOrderQty.text = "\(drinksQty)"
        
        var price = 0
        if cupSizeText == cupSize[0] {
            price = drinksMediumPrice ?? 0  // Medium
        } else {
            price = drinksLargePrice ?? 0   // Large
        }
        
        if toppingText != toppingChoose[0] {
            price += 10
        }
        drinksPriceLabel.text = "$\(drinksQty * price)"
    }

}

// MARK: - text Fields Delegate
extension OrderDetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case cupSizeTextField:
            activateTextField(cupSizeTextField, with: cupSizePickerView, selection: cupSize, debugMessage: "Cup size selected")
            
        case iceLevelTextField:
            activateTextField(iceLevelTextField, with: iceLevelPickerView, selection: iceLevel, debugMessage: "ice Level selected")
            
        case sugarLevelTextField:
            activateTextField(sugarLevelTextField, with: sugarLevelPickerView, selection: sugarLevel, debugMessage: "sugar Level selected")
            
        default:
            activateTextField(toppingTextField, with: toppingPickerView, selection: toppingChoose, debugMessage: "topping Choose selected")
        }
    }
    
    private func activateTextField(_ textField: UITextField, with pickerView: UIPickerView, selection: [String], debugMessage: String) {
        print("DEBUG PRINT: \(debugMessage)")
        let index = pickerView.selectedRow(inComponent: 0)
        textField.text = selection[index]
        textField.becomeFirstResponder()
    }
    
    // MARK: textField Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case cupSizeTextField:
            cupSizePickerView.isHidden = true
            
        case iceLevelTextField:
            iceLevelPickerView.isHidden = true
            
        case sugarLevelTextField:
            sugarLevelPickerView.isHidden = true
            
        case toppingTextField:
            toppingPickerView.isHidden = true
            
        default:
            break
        }
        return true
    }

    
    // MARK: textField Did End Editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cupSizeText = cupSizeTextField.text
        let toppingText = toppingTextField.text
        var price = 0

        // 中杯
        if cupSizeText == cupSize[0] {
            price = drinksMediumPrice ?? 0
            if toppingText != toppingChoose[0] {
                price += 10
            }
        } else {
            // 大杯
            price = drinksLargePrice ?? 0
            if toppingText != toppingChoose[0] {
                price += 10
            }
        }
        
        drinksPriceLabel.text = "$\(Int(drinkStepper.value) * price)"
        print("$\(drinkNameLabel.text!)")
    }


    
    // MARK: textField Did Change Selection
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case cupSizeTextField:
            print(cupSizeTextField.text ?? "Unable to get cupSizeTextField's text")
            
        case iceLevelTextField:
            print(iceLevelTextField.text ?? "Unable to get iceLevelTextField's text")
            
        case sugarLevelTextField:
            print(sugarLevelTextField.text ?? "Unable to get sugarLevelTextField's text")
            
        case toppingTextField:
            print(toppingTextField.text ?? "Unable to get toppingTextField's text")
            
        case userNameTextField:
            print("""
                  DEBUG PRINT: textFieldDidChangeSelection
                  \(textField.text ?? "")
                  """)
        default:
            break
        }
    }
}

// MARK: - PickerView Delegate & DataSource
extension OrderDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: numberOfComponents
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK: numberOfRowsInComponent
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if ( pickerView == cupSizePickerView ) {
            print("DEBUG PRINT: cupSize.count equals \(cupSize.count)")
            return cupSize.count
            
        } else if (pickerView == iceLevelPickerView) {
            print("DEBUG PRINT: iceLevel.count equals \(iceLevel.count)")
            return iceLevel.count
            
        } else if (pickerView == sugarLevelPickerView) {
            print("DEBUG PRINT: sugarLevel.count equals \(sugarLevel.count)")
            return sugarLevel.count
            
        } else if (pickerView == toppingPickerView) {
            print("DEBUG PRINT: toppingChoose.count equals \(toppingChoose.count)")
            return toppingChoose.count
            
        } else {
            return 1
        }
    }
    
    // MARK: didSelectRow
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
    
    // MARK: titleForRow
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == cupSizePickerView {
            print("DEBUG PRINT: 切換到 尺寸PickerView")
            return cupSize[row]
            
        } else if (pickerView == iceLevelPickerView) {
            print("DEBUG PRINT: 切換到 冰塊 PickerView")
            return iceLevel[row]
            
        } else if (pickerView == sugarLevelPickerView) {
            print("DEBUG PRINT: 切換到 甜度 PickerView")
            return sugarLevel[row]
            
        } else if (pickerView == toppingPickerView) {
            print("DEBUG PRINT: 切換到 加料 PickerView")
            return toppingChoose[row]
        }
        return String()
    }
}

#Preview {
    UINavigationController(rootViewController: OrderDetailViewController())
}
