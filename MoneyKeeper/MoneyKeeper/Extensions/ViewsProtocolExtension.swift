//
//  MainViewExtension.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 19.11.2021.
//

import Foundation

protocol UserUpdatingDelegate {
    func updateUser(_ newUser: User)
}

extension MainViewController: UserUpdatingDelegate {
    func updateUser(_ newUser: User) {
        user = newUser
//        updateUI()
    }
}

extension OverviewViewController: UserUpdatingDelegate {
    func updateUser(_ newUser: User) {
        user = newUser
        updateUI()
    }
}
