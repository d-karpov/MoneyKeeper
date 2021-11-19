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
    @IBOutlet weak var grauViewOutlet: UIView!
    
    //Добавил переменную для приема юзера
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartOutletBtn.layer.cornerRadius = 20
        grauViewOutlet.layer.cornerRadius = 20
    }
    @IBAction func undwindSegue(_ sender: UIStoryboardSegue){
        
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  Добавил переход на экран добавления операции.
        if let addAcountVC = segue.destination as? AddOperationViewController {
            addAcountVC.user = user
            addAcountVC.delegate = self
        }
        guard let SV = segue.destination as? SecondViewController else { return }
        SV.cardLabel.textColor = .blue
    }
}
