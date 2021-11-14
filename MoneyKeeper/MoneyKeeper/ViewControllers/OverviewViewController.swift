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
    
    private let incomeAmount: Float = 155441.90
    private let withdrawAmount: Float = 900
    private var balanceAmount: Float {
        incomeAmount - withdrawAmount
    }
    private let amountOfAccounts = Int.random(in: 3...8)
    private let amountOfWithdraws = Int.random(in: 5...12)

    override func viewDidLoad() {
        super.viewDidLoad()

        incomeAmountOutlet.text = incomeAmount.currencyRU
        balanceAmountOutlet.text = withdrawAmount.currencyRU
        withdrawAmountOutlet.text = balanceAmount.currencyRU
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
        case 1: return amountOfAccounts + 1
        default: return amountOfWithdraws + 1
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
            content.text = incomeAmount.currencyRU
        } else if indexPath.section == 1 {
            content.image = UIImage(systemName: "plus.square.dashed")
            content.text = String(indexPath.row)
        } else {
            content.image = UIImage(systemName: "hand.thumbsdown.fill")
            content.text = String(indexPath.row)
        }

        cell.contentConfiguration = content
        return cell
    }
}
