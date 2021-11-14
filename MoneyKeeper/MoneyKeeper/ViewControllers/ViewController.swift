//
//  ViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 13.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        performSegue(withIdentifier: "needed", sender: view)
    }
}

