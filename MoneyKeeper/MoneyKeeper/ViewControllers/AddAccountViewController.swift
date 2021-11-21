//
//  AddAccountViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 18.11.2021.
//

import UIKit

class AddAccountViewController: UIViewController {
    
//MARK: - IBOutlets
    @IBOutlet var accountText: UITextField!
    @IBOutlet var balanceText: UITextField!
    
    @IBOutlet var accountType: UISegmentedControl!
    
    @IBOutlet var detailedStack: UIStackView!
    
//MARK: - Public properties
    var user: User!
    var delegate: UserUpdatingDelegate!
    
//MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        detailedStack.layer.cornerRadius = view.frame.height/50
        accountText.delegate = self
        balanceText.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let accountName = accountText.text else { return }
        guard let balance = Double(balanceText.text ?? "0.0") else { return }
        if !accountName.isEmpty {
            switch accountType.selectedSegmentIndex {
            case 0: user.addAccount(Account(status: .excluded, name: accountName, operations: [], rawMoneyAmount: balance))
            default: user.addAccount(Account(status: .included, name: accountName, operations: [], rawMoneyAmount: balance))
            }
            user.profile.indexOfActiveAccount = user.profile.accounts.endIndex - 1
            user.saveUserToDataManager(DataManager.shared, user)
            delegate.updateUser(user)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
  
    //MARK: - Private methods
    
    private func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default,
                                        handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
//MARK: - IBActions
    @IBAction func changeAccountType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: sender.selectedSegmentTintColor = .systemYellow
        default: sender.selectedSegmentTintColor = .systemGreen
        }
    }
}

//MARK: - UITextFiedlDelegate
extension AddAccountViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let accountName = accountText.text else { return }
        if user.accountIsExist(accountName) {
            textField.text = ""
            callAlert(title: "Account Name Error!", message: "Account \(accountName) is already exist, please use uniq names!")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
