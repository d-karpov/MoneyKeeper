//
//  ChangeTableViewController.swift
//  MoneyKeeper
//
//  Created by EDUARD Latynsky on 15.11.2021.
//

import UIKit

class ChangeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "change", for: indexPath)
    
        var content = cell.defaultContentConfiguration()
        content.text = "I is number \(indexPath.row)"
        cell.contentConfiguration = content

        return cell
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let SV = segue.destination as? SecondViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        SV.cartOutletBtn.setTitle(String(indexPath.row), for: .normal)
    }
}
