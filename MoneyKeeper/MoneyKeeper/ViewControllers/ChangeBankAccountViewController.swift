//
//  ChangeTableViewController.swift
//  MoneyKeeper
//
//  Created by EDUARD Latynsky on 15.11.2021.
//

import UIKit

class ChangeBankAccountViewController: UITableViewController {
    
//MARK: - Publick Properties
    var user: User!
    var delegate: UserUpdatingDelegate!
 
//MARK: - Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? MainViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            if indexPath.row >= user.profile.accounts.count {
                mainVC.selectedAccountIndex = nil
                mainVC.updateUser(user)
            } else {
                mainVC.selectedAccountIndex = indexPath.row
                mainVC.updateUser(user)
            }
        }
    }
    
//MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.profile.accounts.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "change", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if indexPath.row < user.profile.accounts.count {
            content.text = user.profile.accounts[indexPath.row].name
        } else {
            content.text = "Total balance"
            content.imageProperties.tintColor = .black
        }
        content.image = UIImage(systemName: "creditcard.fill")
        cell.contentConfiguration = content
        
        return cell
    }
}
