//
//  Accounts.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

struct Account {
    var status: AccountStatus
    var name: String
    var operations: [Operation]
    var moneyAmount: Double
}

enum AccountStatus {
    case included, excluded
}

extension Account {
    func getActiveOperations() -> [Operation] {
        operations.filter { $0.status == .active }
    }
    
    func getMoneyAmount(_ ofType: CategoriesTypes ) -> Double {
        let operations = getActiveOperations().filter { $0.category.type == ofType }
        return operations.reduce(0.0) { $0 + $1.rawMoneyAmount }
    }
    
    func getMoneyAmount(_ ofName: String ) -> Double {
        let operations = getActiveOperations().filter { $0.category.name == ofName }
        return operations.reduce(0.0) { $0 + $1.rawMoneyAmount }
    }
    
    mutating func updateMoneyAmount() {
        moneyAmount += getActiveOperations().reduce(0.0) { $0 + $1.moneyAmount }
    }
    
    static func getTestAccounts() -> [Account] {
        let dataManager = DataManager.shared
        return [ Account(status: .included,
                         name: dataManager.testAccountName,
                         operations: [],
                         moneyAmount: dataManager.testAccountMoney)]
    }
}
