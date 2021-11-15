//
//  Accounts.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

//MARK: - Account Struct

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

//MARK: - Account public and private methods

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
    
    mutating func addOperation(_ newOperaion: Operation) {
        operations.append(newOperaion)
    }
    
    private func updateMoneyAmount() -> Double {
        getActiveOperations().reduce(rawMoneyAmount) { $0 + $1.moneyAmount }
    }
    
    
}

//MARK: - Account static methods

extension Account {
    static func getTestAccounts() -> [Account] {
        let dataSet = TestDataSet.shared
        return [ Account(status: .included,
                         name: dataSet.testAccountName,
                         operations: Operation.getTestOperations(),
                         rawMoneyAmount: dataSet.testAccountMoney) ]
    }
}
