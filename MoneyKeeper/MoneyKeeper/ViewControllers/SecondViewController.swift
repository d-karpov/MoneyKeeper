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
    
    //Добавил переменную для приема юзера
    var user: User!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var grayViewOutlet: UIView!
    
    @IBOutlet var buttonOutlets: [UIButton]!
    
    @IBOutlet weak var nameLabel: UILabel!
        
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
        //  Добавил переход на экран добавления операции.
        if let addAcountVC = segue.destination as? AddOperationViewController {
            addAcountVC.user = user
            addAcountVC.delegate = self
        }
        guard let SV = segue.destination as? SecondViewController else { return }
        SV.cardLabel.textColor = .blue
    @IBAction func undwindSegue(_ sender: UIStoryboardSegue){
    }
    
}
