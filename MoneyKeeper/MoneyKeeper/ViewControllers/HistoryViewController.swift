//
//  HistoryViewController.swift
//  MoneyKeeper
//
//  Created by xubuntus on 16.11.2021.
//

import UIKit

class HistoryViewController: UIViewController {
//MARK: - IBOutlets
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
//MARK: - Publick Properties
    var itemType: String!
    var itemName: String!
    var operations: [Operation]!

//MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelHeaderColor: UIColor
        switch itemType {
        case "income": iconImageView.image = UIImage(systemName: "hand.thumbsup.fill")
            labelHeaderColor = .systemGreen
        case "account": iconImageView.image = UIImage(systemName: "rectangle")
            labelHeaderColor = .systemOrange
        case "user": iconImageView.image = UIImage(systemName: "person")
            labelHeaderColor = .systemRed
        default: iconImageView.image = UIImage(systemName: "hand.thumbsdown.fill")
            labelHeaderColor = .systemYellow
        }
        
        iconImageView.tintColor = labelHeaderColor
        nameLabel.textColor = labelHeaderColor
        nameLabel.text = itemName
        amountLabel.text = operations.reduce(0.0) { $0 + $1.moneyAmount }.currencyRU
    }
}

//MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        getUniqueDates(ofOperationArray: operations).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        getUniqueDates(ofOperationArray: operations)[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        operations.filter {string(ofDate: $0.date) == getUniqueDates(ofOperationArray: operations)[section]}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyRow", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let operationsInSection = operations.filter {string(ofDate: $0.date) == getUniqueDates(ofOperationArray: operations)[indexPath.section]}.sorted(by: {$0.date > $1.date})
        content.text = operationsInSection[indexPath.row].category.name
        content.secondaryText = operationsInSection[indexPath.row].moneyAmount.currencyRU
        
        let labelHeaderColor: UIColor
        switch operationsInSection[indexPath.row].category.type {
        case .income: content.image = UIImage(systemName: "hand.thumbsup.fill")
            labelHeaderColor = .systemGreen
        case .withdraw: content.image = UIImage(systemName: "hand.thumbsdown.fill")
            labelHeaderColor = .systemYellow
        }
        cell.tintColor = labelHeaderColor
        
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
