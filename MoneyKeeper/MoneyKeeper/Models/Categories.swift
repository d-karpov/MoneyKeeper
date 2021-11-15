//
//  Categoies.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

//MARK: - Category Struct

struct Category {
    let name: String
    var type: CategoriesTypes
}

enum CategoriesTypes {
    case income, withdraw
}

//MARK: - Category static methods

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

//MARK: - Category Equatable Methods

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
            return lhs.name == rhs.name && lhs.type == rhs.type
        }
}
