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
        //TEST
        addTestOperations()
        //
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        getUniqueOperationDates().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        getUniqueOperationDates()[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        operations.filter {string(ofDate: $0.date) ==  getUniqueOperationDates()[section]}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyRow", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = operations.filter {string(ofDate: $0.date) ==  getUniqueOperationDates()[indexPath.section]}[indexPath.row].category.name
        content.secondaryText = operations.filter {string(ofDate: $0.date) ==  getUniqueOperationDates()[indexPath.section]}[indexPath.row].moneyAmount.currencyRU
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}

extension HistoryViewController {
    func addTestOperations() -> Void {
        switch itemType {
        case "income": operations.append(Operation(date: Date.now, status: .active, category: Category(name: "Salary", type: .income), rawMoneyAmount: 456.78))
            operations.append(Operation(date: Date(timeIntervalSinceNow: -86400), status: .active, category: Category(name: "Salary", type: .income), rawMoneyAmount: 1200))
        case "account": operations.removeAll()
            operations.append(Operation(date: Date.now, status: .active, category: Category(name: "Salary", type: .income), rawMoneyAmount: 5000))
            operations.append(Operation(date: Date(timeIntervalSinceNow: -86400), status: .active, category: Category(name: "Food", type: .withdraw), rawMoneyAmount: 800.50))
            operations.append(Operation(date: Date.now, status: .active, category: Category(name: "Food", type: .withdraw), rawMoneyAmount: 1200))
        default: operations.append(Operation(date: Date(timeIntervalSinceNow: -172800), status: .active, category: Category(name: "Food", type: .withdraw), rawMoneyAmount: 1200))
        }
        
    }
    
    private func string(ofDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: ofDate)
    }
    
    private func getUniqueOperationDates() -> [String] {
        var uniqueDates: [String] = []
        operations.forEach {
            uniqueDates.append(string(ofDate: $0.date))
        }
        
        return uniqueDates.uniqued().sorted()
    }
}
