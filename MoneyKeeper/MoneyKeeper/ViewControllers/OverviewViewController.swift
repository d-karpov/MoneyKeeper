//
//  OverviewViewController.swift
//  MoneyKeeper
//
//  Created by xubuntus on 14.11.2021.
//

import UIKit

protocol OverviewUserUpdatingDelegate {
    func updateUser(_ newUser: User)
}


class OverviewViewController: UIViewController {
    
    @IBOutlet var topInfoViewOutlet: UIView!

    @IBOutlet var incomeAmountOutlet: UILabel!
    @IBOutlet var balanceAmountOutlet: UILabel!
    @IBOutlet var withdrawAmountOutlet: UILabel!
    
    @IBOutlet var overviewTableView: UITableView!
    
    var user: User!

    private var userIncomeCategories: [Category] {
        user.getAllCategoriesByType(.income)
    }
    private var userWithdrawCategories: [Category] {
        user.getAllCategoriesByType(.withdraw)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        incomeAmountOutlet.text = user.getTotalIncome().currencyRU
        balanceAmountOutlet.text = user.getTotalMoneyAmount().currencyRU
        withdrawAmountOutlet.text = user.getTotalWithdraw().currencyRU
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topInfoViewOutlet.layer.cornerRadius = view.frame.width / 20
        topInfoViewOutlet.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Добавлено для перехода на добавление категории, делегат описан в OverviewExtension
        if let addCategoryVC = segue.destination as? AddCategoryViewController {
            addCategoryVC.delegate = self
        }
        
        guard let historyVC = segue.destination as? HistoryViewController else { return }
        guard let indexPath = overviewTableView.indexPathForSelectedRow else { return }
        switch indexPath.section {
        case 0: historyVC.itemType = "income"
            historyVC.itemName = userIncomeCategories[indexPath.row].name
            historyVC.operations = user.getAllOperationsByCattegory(userIncomeCategories[indexPath.row].name)
        case 1: historyVC.itemType = "account"
            historyVC.itemName = user.profile.accounts[indexPath.row].name
            historyVC.operations = user.profile.accounts[indexPath.row].getActiveOperations()
        default: historyVC.itemType = "withdraw"
            historyVC.itemName = userWithdrawCategories[indexPath.row].name
            historyVC.operations = user.getAllOperationsByCattegory(userWithdrawCategories[indexPath.row].name)
        }
        
    }
}

extension OverviewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return userIncomeCategories.count + 1
        case 1: return user.profile.accounts.count + 1
        default: return userWithdrawCategories.count + 1
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Income"
        case 1: return "Accounts"
        default: return "Withdraw"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewRow", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            if indexPath.row < userIncomeCategories.count {
                content.image = UIImage(systemName: "hand.thumbsup.fill")
                content.text = userIncomeCategories[indexPath.row].name
                content.secondaryText = user.getTotalInCategory(userIncomeCategories[indexPath.row].name).currencyRU
            } else {
                content.image = UIImage(systemName: "plus.square.dashed")
                content.text = "Add category"
            }
            cell.tintColor = .systemGreen
        } else if indexPath.section == 1 {
            if indexPath.row < user.profile.accounts.count {
                content.image = UIImage(systemName: "rectangle")
                content.text = user.profile.accounts[indexPath.row].name
                content.secondaryText = user.profile.accounts[indexPath.row].moneyAmount.currencyRU
            } else {
                content.image = UIImage(systemName: "plus.square.dashed")
                content.text = "Add account"
            }
            cell.tintColor = .systemOrange
        } else {
            if indexPath.row < userWithdrawCategories.count {
                content.image = UIImage(systemName: "hand.thumbsdown.fill")
                content.text = userWithdrawCategories[indexPath.row].name
                content.secondaryText = user.getTotalInCategory(userWithdrawCategories[indexPath.row].name).currencyRU
            } else {
                content.image = UIImage(systemName: "plus.square.dashed")
                content.text = "Add category"
            }
            cell.tintColor = .systemYellow
        }

        cell.contentConfiguration = content
        
        return cell
    }
}

extension OverviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionCount: Int
        switch indexPath.section {
        case 0: sectionCount = userIncomeCategories.count
        case 1: sectionCount = user.profile.accounts.count
        default: sectionCount = userWithdrawCategories.count
        }
        //Временное решение для перехода - переделай под свой кодстайл
        if indexPath.row == sectionCount {
            performSegue(withIdentifier: "addCategory", sender: nil)
        }
        
        
        if indexPath.row < sectionCount {
            performSegue(withIdentifier: "historySegue", sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
