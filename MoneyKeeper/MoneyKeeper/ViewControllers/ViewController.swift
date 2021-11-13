//
//  ViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 13.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstDev: UILabel!
    @IBOutlet var secondDev: UILabel!
    @IBOutlet var thirdDev: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondDev.text = "Ed"
    }
}

