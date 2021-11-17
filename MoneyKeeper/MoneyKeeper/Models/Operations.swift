//
//  Operations.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

//MARK: - Operation Struct

struct Operation {
    var date: Date
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

//MARK: - Operation static methods

extension Operation {
    static func getTestOperations() -> [Operation] {
        var result: [Operation] = []
        let testCategories = Category.getStartCategory()
        for testCategory in testCategories {
            result.append(Operation(date: Date.now,
                                    status: .active,
                                    category: testCategory,
                                    rawMoneyAmount: 1000.0))
        }
        return result
    }
}
