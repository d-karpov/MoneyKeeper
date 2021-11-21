//
//  ChangeTableViewController.swift
//  MoneyKeeper
//
//  Created by EDUARD Latynsky on 15.11.2021.
//

import UIKit

class ChangeBankAccountViewController: UITableViewController {
//MARK: - Properties
    var user: User!
    var delegate: UserUpdatingDelegate!
 
//MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.profile.accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "change", for: indexPath)

        let accountName = user.profile.accounts[indexPath.row].name
        var content = cell.defaultContentConfiguration()
        content.text = accountName
        content.image = UIImage(systemName: "creditcard.fill")
        cell.contentConfiguration = content
        
        return cell
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? MainViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }

        user.profile.indexOfActiveAccount = indexPath.row
        mainVC.updateUser(user)
    }
    
}

