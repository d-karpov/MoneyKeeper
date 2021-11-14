//
//  Categoies.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

struct Category {
    let name: String
    var type: CategoriesTypes
}

enum CategoriesTypes {
    case income, withdraw
}

extension Category {
    static func getStartCategory() -> [Category] {
        let dataManger = TestDataSet.shared
        var result: [Category] = []
        dataManger.startCategoriesNames.forEach {
            if $0 == "Salary" {
                result.append(Category(name: $0, type: .income))
            } else {
                result.append(Category(name: $0, type: .withdraw))
            }
        }
        return result
    }
}
