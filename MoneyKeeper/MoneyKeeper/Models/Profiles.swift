//
//  Profiles.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 17.11.2021.
//

import Foundation

//MARK: - Profile struct
struct Profile {
    let name: String
    let surname: String
    var categories: [Category]
    var accounts: [Account]
    
    var fullname: String {
        "\(name) \(surname)"
    }
}

//MARK: - Profile static methods
extension Profile {
    static func getTestProfile() -> Profile {
        let dataSet = TestDataSet.shared
        return Profile(name: dataSet.testName,
                       surname: dataSet.testSurname,
                       categories: Category.getStartCategory(),
                       accounts: Account.getTestAccounts())
    }
}
