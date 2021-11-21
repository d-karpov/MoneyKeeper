//
//  ViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 13.11.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
//MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = view.frame.width / 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setUpViewControllers()
    }
     
//MARK: - Private methods
    private func setUpViewControllers() {
        let user = User.getUserByLogin(DataManager.shared, "User")
        if let viewControllers = viewControllers {
            for viewController in viewControllers {
                if let profileVC = viewController as? ProfileViewController {
                    profileVC.user = user
                }
                if let overviewVC = viewController as? OverviewViewController {
                    overviewVC.user = user
                    if overviewVC.isViewLoaded {
                        overviewVC.updateUI()
                    }
                }
                if let mainVC = viewController as? MainViewController {
                    mainVC.user = user
                }
            }
        }
    }
}

//MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setUpViewControllers()
    }
}
