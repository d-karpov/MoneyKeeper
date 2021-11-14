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
    
    private let user = DataManager.shared.user
    //private let user = dataManager.user

    override func viewDidLoad() {
        super.viewDidLoad()
        incomeAmountOutlet.text = user.profile.getTotalIncome().currencyRU
        balanceAmountOutlet.text = user.profile.getTotalMoneyAmount().currencyRU
        withdrawAmountOutlet.text = user.profile.getTotalWithdraw().currencyRU
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
        case 0: return 1
        case 1: return user.profile.accounts.count + 1
        default: return user.profile.categories.count + 1
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
            content.image = UIImage(systemName: "hand.thumbsup.fill")
            content.text = user.profile.getTotalIncome().currencyRU
        } else if indexPath.section == 1 {
            if indexPath.row < user.profile.accounts.count {
                content.image = UIImage(systemName: "rectangle")
                content.text = user.profile.accounts[indexPath.row].name
                content.secondaryText = user.profile.accounts[indexPath.row].moneyAmount.currencyRU
            } else {
                content.image = UIImage(systemName: "plus.square.dashed")
                content.text = "Add account"
            }
        } else {
            if indexPath.row < user.profile.categories.count {
                content.image = UIImage(systemName: "hand.thumbsdown.fill")
                content.text = user.profile.categories[indexPath.row].name
                content.secondaryText = 0.currencyRU
            } else {
                content.image = UIImage(systemName: "plus.square.dashed")
                content.text = "Add category"
            }
        }

        cell.contentConfiguration = content
        return cell
    }
}
