//
//  SecondViewController.swift
//  MoneyKeeper
//
//  Created by EDUARD Latynsky on 15.11.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var cartOutletBtn: UIButton!
    
    @IBOutlet var buttonOutlets: [UIButton]!
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet var historyTableView: UITableView!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var grayViewOutlet: UIView!

    var user: User!
    
    private var lastOperations: [Operation] {
        user.getAllActiveOperations().sorted(by: {$0.date > $1.date})
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlets.forEach {
            $0.layer.cornerRadius = 10
        }
    }
    
    override func viewWillLayoutSubviews() {
        cartOutletBtn.layer.cornerRadius = view.frame.width / 15
        grayViewOutlet.layer.cornerRadius = view.frame.width / 15
    }
       
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addAccountVC = segue.destination as? AddOperationViewController {
            addAccountVC.user = user
            addAccountVC.delegate = self
        } else if let historyVC = segue.destination as? HistoryViewController {
            if let _ = sender as? UIButton {
                historyVC.itemType = "account"
                historyVC.itemName = "name"
                historyVC.operations = []
            } else {
                historyVC.itemType = "user"
                historyVC.itemName = user.profile.name
                historyVC.operations = user.getMonthlyAllOperations()
            }
        }
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lastOperations.filter {string(ofDate: $0.date) == getUniqueDates(ofOperationArray: lastOperations)[section]}.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        getUniqueDates(ofOperationArray: lastOperations).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        getUniqueDates(ofOperationArray: lastOperations)[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lastOperationsRow", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let operationsInSection = lastOperations.filter {string(ofDate: $0.date) == getUniqueDates(ofOperationArray: lastOperations)[indexPath.section]}.sorted(by: {$0.date > $1.date})
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

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "historySegue", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
