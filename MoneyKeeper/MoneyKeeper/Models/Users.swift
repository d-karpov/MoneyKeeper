//
//  Users.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

struct User {
    let login: String
    let password: String
    let profile: Profile
}

struct Profile {
    let name: String
    let surname: String
    var categories: [Category]
    var accounts: [Account]
    
    var fullname: String {
        "\(name) \(surname)"
    }
}

extension User {
    static func getTestUsers() -> [User]{
        let dataManager = DataManager.shared
        return [User(login: dataManager.testLogin,
                     password: dataManager.testPassword,
                     profile: Profile.getTestProfile())]
    }
}

extension Profile {
    func getTotalMoneyAmount() -> Double {
        accounts.reduce(0.0) { $0 + $1.moneyAmount }
    }
    
    func getTotalWithdraw() -> Double {
        accounts.reduce(0.0) { $0 + $1.getMoneyAmount(.withdraw) }
    }
    
    func getTotalIncome() -> Double {
        accounts.reduce(0.0) { $0 + $1.getMoneyAmount(.income) }
    }
    
    func getAllActiveOperations() -> [Operation] {
        accounts.flatMap { $0.getActiveOperations() }
    }
    
    static func getTestProfile() -> Profile {
        let dataManager = DataManager.shared
        return Profile(name: dataManager.testName,
                       surname: dataManager.testSurname,
                       categories: Category.getStartCategory(),
                       accounts: Account.getTestAccounts())
    }
}
