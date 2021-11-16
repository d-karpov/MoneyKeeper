//
//  ViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 13.11.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
   
    let dataManager = DataManager.shared
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = view.frame.width / 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setUpViewCOntrollers()
    }
    
    private func setUpViewCOntrollers() {
        if let viewControllers = viewControllers {
            for viewController in viewControllers {
                if let profileVC = viewController as? ProfileViewController {
                    profileVC.user = User.getUserByLogin(dataManager, "User")
                } else if let overviewVC = viewController as? OverviewViewController {
                    overviewVC.user = User.getUserByLogin(dataManager, "User")
                }
            }
        }
        
    }
    
}




