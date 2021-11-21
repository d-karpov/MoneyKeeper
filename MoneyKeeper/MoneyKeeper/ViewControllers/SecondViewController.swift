//
//  SecondViewController.swift
//  MoneyKeeper
//
//  Created by EDUARD Latynsky on 15.11.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var cardButton: UIButton!
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var grayViewOutlet: UIView!
    
    @IBOutlet var buttonOutlets: [UIButton]!
    
    var user: User!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardButton.setTitle(
        """
        Bank: \(user.profile.accounts.map{$0.name}.joined(separator: ", "))
        Balance: \(user.profile.accounts.map{String(format: "%.2f", $0.moneyAmount)}.joined(separator: ", "))
        """, for: .normal)
    }
    override func viewWillLayoutSubviews() {
        cardButton.layer.cornerRadius = view.frame.width / 15
        grayViewOutlet.layer.cornerRadius = view.frame.width / 15
        buttonOutlets.forEach {
            $0.layer.cornerRadius = view.frame.width / 30
        }        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addAcountVC = segue.destination as? AddOperationViewController {
            addAcountVC.user = user
            addAcountVC.delegate = self
        } else if let changeVC = segue.destination as? ChangeBankAccountViewController {
            changeVC.user = user
        }
    }
    
    @IBAction func undwindSegue(_ sender: UIStoryboardSegue){
    }
}

