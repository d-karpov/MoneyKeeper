//
//  AddOperationViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 18.11.2021.
//

import UIKit

class AddOperationViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var detailedStack: UIStackView!
    
    @IBOutlet var categoryText: UITextField!
    @IBOutlet var amountText: UITextField!
    @IBOutlet var dateText: UITextField!
    @IBOutlet var accountText: UITextField!
    
    @IBOutlet var categoryType: UISegmentedControl!
    @IBOutlet var newOrExist: UISegmentedControl!
    
    //MARK: - Public properties
    var user: User!
    var delegate: MainViewUserUpdatingDelegate!
    var account: Account!
    
    //MARK: - Private properrties
    private var operationCategory: Category!
    private var operationType: CategoriesTypes {
        switch categoryType.selectedSegmentIndex {
        case 0: return .withdraw
        default: return .income
        }
    }
    private var accountPicker: UIPickerView!
    private var categoryPicker: UIPickerView!
    private var datePicker: UIDatePicker!
    
    //MARK: - Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryText.delegate = self
        
        accountPicker = UIPickerView()
        accountPicker.delegate = self
        accountText.delegate = self
        accountText.inputView = accountPicker
        
        datePicker = UIDatePicker()
        dateText.delegate = self
        datePicker.preferredDatePickerStyle = .inline
        dateText.inputView = datePicker
        dateText.text = Date.now.formatted(date: .long, time: .omitted)
        
        changeInputType()
        categoryType.isHidden = true
        detailedStack.layer.cornerRadius = view.frame.height/50
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if operationCategory != nil && accountText.hasText {
            guard let accountName = accountText.text else { return }
            guard let money = Double(amountText.text ?? "0.0") else { return }
            if !user.profile.categories.contains(operationCategory) {
                user.addCategory(operationCategory)
            }
            user.addOperation(accountName, Operation(date: datePicker.date,
                                                   status: .active,
                                                   category: operationCategory,
                                                   rawMoneyAmount: money))
            user.saveUserToDataManager(DataManager.shared, user)
            delegate.updateUser(user)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func changeSelectors(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: sender.selectedSegmentTintColor = .systemYellow
        default: sender.selectedSegmentTintColor = .systemGreen
        }
        switch sender {
        case newOrExist: changeInputType()
        default: updateCategory()
        }
    }
    
    //MARK: - Private methods
    private func updateCategory() {
        guard let categoryName = categoryText.text else { return }
        if !categoryName.isEmpty {
            if !user.profile.categories.contains(where: { $0.name == categoryName }) {
                categoryType.isHidden = false
                operationCategory = Category(name: categoryName, type: operationType)
            } else if user.profile.categories.filter({ $0.name == categoryName }).count > 1 {
                categoryType.isHidden = false
                operationCategory = user.getAllCategoriesByType(operationType).first { $0.name == categoryName }
            } else {
                categoryType.isHidden = true
                operationCategory = user.profile.categories.first { $0.name == categoryName }
            }
        }
    }
    
    private func changeInputType(){
        view.endEditing(true)
        categoryType.isHidden = true
        switch newOrExist.selectedSegmentIndex {
        case 0: categoryText.inputView = categoryPicker
        default: categoryText.inputView = nil
        }
    }
}

//MARK: - UIPickerViewDataSource
extension AddOperationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case categoryPicker: return user.profile.categories.count
        default: return user.profile.accounts.count
        }
    }
}

//MARK: - UIPickerViewDelegate
extension AddOperationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categoryPicker: return user.profile.categories[row].name
        default: return user.profile.accounts[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case categoryPicker:
            categoryText.text = user.profile.categories[row].name
        default:
            accountText.text = user.profile.accounts[row].name
        }
    }
}

//MARK: - UITextFieldDelegate
extension AddOperationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateText {
            textField.text = datePicker.date.formatted(date: .long, time: .omitted)
        }
        updateCategory()
    }
}
