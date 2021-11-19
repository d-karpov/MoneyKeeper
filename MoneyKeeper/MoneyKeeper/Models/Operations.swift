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

//MARK: - Public methods
extension Operation {
    func compareDateWithNow() -> Bool {
        let calendar = Calendar.current
        guard let interval = calendar.dateComponents([.day], from: date, to: Date.now).day else { return false }
        return interval <= 30
    }
}

//MARK: - Operation static methods

extension Operation {
    static func getTestOperations() -> [Operation] {
        var result: [Operation] = []
//        let testCategories = Category.getStartCategory()
//        for testCategory in testCategories {
//            result.append(Operation(date: Date.now,
//                                    status: .active,
//                                    category: testCategory,
//                                    rawMoneyAmount: 1000.0))
//        }
        result.append(Operation(date: Date.now, status: .active, category: Category(name: "Salary", type: .income), rawMoneyAmount: 5000))
        result.append(Operation(date: Date.now, status: .active, category: Category(name: "Food", type: .withdraw), rawMoneyAmount: 1200))
        result.append(Operation(date: Date.now, status: .active, category: Category(name: "Car", type: .withdraw), rawMoneyAmount: 3000))
        result.append(Operation(date: Date(timeIntervalSinceNow: -1 * 86400), status: .active, category: Category(name: "Food", type: .withdraw), rawMoneyAmount: 800.50))
        result.append(Operation(date: Date(timeIntervalSinceNow: -1 * 86400), status: .active, category: Category(name: "Food", type: .withdraw), rawMoneyAmount: 540))
        result.append(Operation(date: Date(timeIntervalSinceNow: -2 * 86400), status: .active, category: Category(name: "Health", type: .withdraw), rawMoneyAmount: 930))
        result.append(Operation(date: Date(timeIntervalSinceNow: -3 * 86400), status: .active, category: Category(name: "Food", type: .withdraw), rawMoneyAmount: 1834.10))
        
        return result
    }
}
