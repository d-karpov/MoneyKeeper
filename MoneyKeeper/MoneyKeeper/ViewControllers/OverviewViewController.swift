//
//  OverviewViewController.swift
//  MoneyKeeper
//
//  Created by xubuntus on 14.11.2021.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet var topInfoViewOutlet: UIView!

    @IBOutlet var incomeAmountOutlet: UILabel!
    @IBOutlet var balanceAmountOutlet: UILabel!
    @IBOutlet var withdrawAmountOutlet: UILabel!
    
    private let user = DataManager.shared.users[0]
    //private let user = dataManager.user
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
        default: return "Withdraw categories"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewRow", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        if indexPath.section == 0 {
            if indexPath.row < userIncomeCategories.count {
                content.image = UIImage(systemName: "hand.thumbsup.fill")
                content.text = userIncomeCategories[indexPath.row].name
                content.secondaryText = 0.currencyRU
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
                content.secondaryText = 0.currencyRU
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
