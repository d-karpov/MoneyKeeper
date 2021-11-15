//
//  SecondViewController.swift
//  MoneyKeeper
//
//  Created by EDUARD Latynsky on 15.11.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var cartOutletBtn: UIButton!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var bottomOutView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartOutletBtn.layer.cornerRadius = 20
    }
    @IBAction func undwindSegue(_ sender: UIStoryboardSegue){
        
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let SV = segue.destination as? SecondViewController else { return }
        SV.cardLabel.textColor = .blue
    }
}
