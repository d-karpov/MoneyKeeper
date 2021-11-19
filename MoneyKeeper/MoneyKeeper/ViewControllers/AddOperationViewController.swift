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
    
    @IBOutlet var categoryType: UISegmentedControl!
    @IBOutlet var newOrExist: UISegmentedControl!
    
    //MARK: - Public properties
    var user: User!
    
    //MARK: - Private properrties
    private var operationCategory: Category!
    private var operationType: CategoriesTypes {
        switch categoryType.selectedSegmentIndex {
        case 0: return .withdraw
        default: return .income
        }
    }
    private var picker: UIPickerView!
    
    //MARK: - Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        picker = UIPickerView()
        picker.delegate = self
        categoryText.delegate = self
        changeInputType()
        categoryType.isHidden = true
        detailedStack.layer.cornerRadius = view.frame.height/50
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let money = Double(amountText.text ?? "0.0") else { return }
        if operationCategory != nil {
            if !user.profile.categories.contains(operationCategory) {
                user.addCategory(operationCategory)
            }
            user.addOperation("Tinkoff", Operation(date: Date.now,
                                                   status: .active,
                                                   category: operationCategory,
                                                   rawMoneyAmount: money))
            user.saveUserToDataManager(DataManager.shared, user)
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
        case 0: categoryText.inputView = picker
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
        user.profile.categories.count
    }
}

//MARK: - UIPickerViewDelegate
extension AddOperationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        user.profile.categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryText.text = user.profile.categories[row].name
    }
}

//MARK: - UITextFieldDelegate
extension AddOperationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateCategory()
    }
}
