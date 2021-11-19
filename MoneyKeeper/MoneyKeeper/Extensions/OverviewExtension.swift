//
//  OverviewExtension.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 17.11.2021.
//

import UIKit

protocol OverviewUserUpdatingDelegate {
    func updateUser(_ newUser: User)
}

extension OverviewViewController: OverviewUserUpdatingDelegate {
    func updateUser(_ newUser: User) {
        user = newUser
        incomeAmountOutlet.text = user.getTotalIncome().currencyRU
        balanceAmountOutlet.text = user.getTotalMoneyAmount().currencyRU
        withdrawAmountOutlet.text = user.getTotalWithdraw().currencyRU
        overviewTableView.reloadData()
    }
}
