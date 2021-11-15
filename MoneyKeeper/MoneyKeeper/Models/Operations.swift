//
//  Operations.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

struct Operation {
//    let date: Date
    var status: OperationStatus
    var category: Category
    var rawMoneyAmount: Double
    var moneyAmount: Double {
        get {
            switch category.type {
            case .withdraw:
                return -rawMoneyAmount
            default:
                return rawMoneyAmount
            }
        }
        set {
            rawMoneyAmount = newValue
        }
    }
}

enum OperationStatus {
    case active, deleted
}
