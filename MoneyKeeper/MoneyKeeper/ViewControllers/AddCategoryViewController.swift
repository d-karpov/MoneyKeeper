//
//  AddCategoryViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 17.11.2021.
//

import UIKit

class AddCategoryViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var categoryType: UISegmentedControl!
    
    @IBOutlet var categoryName: UITextField!
    
    //MARK: - Public properties
    let dataManager = DataManager.shared
    var delegate: OverviewUserUpdatingDelegate!
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryName.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard var user = User.getUserByLogin(dataManager, "User") else { return }
        guard let inputText = categoryName.text else { return }
        if !inputText.isEmpty {
            switch categoryType.selectedSegmentIndex {
            case 0: user.addCategory(Category(name: inputText, type: .withdraw))
            default: user.addCategory(Category(name: inputText, type: .income))
            }
            user.saveUserToDataManager(dataManager, user)
            delegate.updateUser(user)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func changeCategoryType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: sender.selectedSegmentTintColor = .systemYellow
        default: sender.selectedSegmentTintColor = .systemGreen
        }
    }
}

//MARK: - UITextFieldDelegate
extension AddCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
