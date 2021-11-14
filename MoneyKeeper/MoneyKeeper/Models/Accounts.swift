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
    var rawMoneyAmount: Double
    var moneyAmount: Double {
        get {
            updateMoneyAmount()
        }
        
        set {
            rawMoneyAmount = newValue
        }
    }
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
    
    private func updateMoneyAmount() -> Double {
        let result = getActiveOperations().reduce(rawMoneyAmount) { $0 + $1.moneyAmount }
        return result
    }
    
    static func getTestAccounts() -> [Account] {
        let dataSet = TestDataSet.shared
        return [ Account(status: .included,
                         name: dataSet.testAccountName,
                         operations: [Operation(status: .active, category: Category(name: "Health", type: .withdraw), rawMoneyAmount: 1000)],
                         rawMoneyAmount: dataSet.testAccountMoney)]
    }
}
