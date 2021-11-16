//
//  ProfileViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 16.11.2021.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    var user: User!
    
    private let team = TeamDataSet.shared
    
    override func viewDidLoad() {
        tableView.rowHeight = 150
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "User Profile"
        default: return "About Team"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = user.profile.fullname
            cell.contentConfiguration = content
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = team.names[indexPath.row]
            content.secondaryText = team.description[indexPath.row]
            content.image = UIImage(named: "den")
            content.imageProperties.cornerRadius = tableView.rowHeight/2
            cell.contentConfiguration = content
            return cell
        }
    }
}
