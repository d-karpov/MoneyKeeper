//
//  MainViewExtension.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 19.11.2021.
//

import Foundation

protocol MainViewUserUpdatingDelegate {
    func updateUser(_ newUser: User)
}

extension SecondViewController: MainViewUserUpdatingDelegate {
    func updateUser(_ newUser: User) {
        user = newUser
        historyTableView.reloadData()
    }
}
