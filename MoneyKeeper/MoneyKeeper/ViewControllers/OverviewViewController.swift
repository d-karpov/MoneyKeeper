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
