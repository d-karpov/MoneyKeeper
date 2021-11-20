//
//  ChangeTableViewController.swift
//  MoneyKeeper
//
//  Created by EDUARD Latynsky on 15.11.2021.
//

import UIKit

class ChangeBankAccountViewController: UITableViewController {
    private let user = User.getTestUsers()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.map{$0.profile.accounts}.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "change", for: indexPath)
        let accountName = user.map{$0.profile.accounts}[indexPath.row]
                                     .map{$0.name}.joined(separator: ", ")
        
        var content = cell.defaultContentConfiguration()
        content.text = accountName
        content.image = UIImage(systemName: "creditcard.fill")
        cell.contentConfiguration = content
        
        return cell
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let SV = segue.destination as? SecondViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let account = user.map{$0.profile.accounts}[indexPath.row]
        SV.cartOutletBtn.setTitle(
            "Bank: \(account.map{$0.name}.joined(separator: ", ")) \nBalance: \(account.map{"\($0.rawMoneyAmount)"}.joined(separator: ", "))",
            for: .normal)
        SV.nameLabel.text = user.map{$0.profile.fullname}.joined(separator: ", ")
    }
    
}
