//
//  HistoryViewController.swift
//  MoneyKeeper
//
//  Created by xubuntus on 16.11.2021.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    var itemType: String!
    var itemName: String!
    var operations: [Operation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelHeaderColor: UIColor
        switch itemType {
        case "income": iconImageView.image = UIImage(systemName: "hand.thumbsup.fill")
            labelHeaderColor = .systemGreen
        case "account": iconImageView.image = UIImage(systemName: "rectangle")
            labelHeaderColor = .systemOrange
        default: iconImageView.image = UIImage(systemName: "hand.thumbsdown.fill")
            labelHeaderColor = .systemYellow
        }
        
        iconImageView.tintColor = labelHeaderColor
        nameLabel.textColor = labelHeaderColor
        nameLabel.text = itemName
        amountLabel.text = operations.reduce(0.0) { $0 + $1.moneyAmount }.currencyRU
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyRow", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "123"
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
