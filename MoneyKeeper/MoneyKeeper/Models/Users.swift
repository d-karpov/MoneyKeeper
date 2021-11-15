//
//  Users.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import Foundation

//MARK: - User struct

struct User {
    let login: String
    let password: String
    var profile: Profile
    var categories: [Category]
    var accounts: [Account]
}

//MARK: - User public methods

extension User {
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
    
    func getTotalInCategory( _ name: String ) -> Double {
        accounts.reduce(0.0) { $0 + $1.getMoneyAmount(name)}
    }
    
    func getAllCategoriesByType(_ type: CategoriesTypes) -> [Category] {
        categories.filter { $0.type == type }
    }
    
    func getAccountByName (_ name: String) -> Account? {
        accounts.first { $0.name == name }
    }
    //MARK: - Mutating methods
    
    mutating func addCategory(_ newCategory: Category) {
        if !categories.contains(where: {$0 == newCategory}) {
            categories.append(newCategory)
        }
    }
        
    mutating func addOperation(_ toAccount: String, _ newOperation: Operation) {
        guard let index = getAccountIndex(toAccount) else { return }
        accounts[index].addOperation(newOperation)
    }
    
    // MARK: - Save User to DataManager method
    
    func saveUserToDataManager(_ source: DataManager, _ updatedUser: User) {
        guard let index = getUserIndexbyLogin(source, updatedUser.login) else { return }
        source.users[index] = updatedUser
    }
}

//MARK: - User private methods

extension User {
    private func getAccountIndex(_ name: String) -> Int? {
        accounts.firstIndex(where: { $0.name == name})
    }
    
    private func getUserIndexbyLogin(_ source: DataManager, _ login: String) -> Int? {
        source.users.firstIndex(where: { $0.login == login })
    }
}

// MARK: - User static methods

extension User {
    static func getTestUsers() -> [User] {
        let dataSet = TestDataSet.shared
        return [User(login: dataSet.testLogin,
                     password: dataSet.testPassword,
                     profile: Profile.getTestProfile(),
                     categories: Category.getStartCategory(),
                     accounts: Account.getTestAccounts())]
    }
    
    static func getUserByLogin(_ source: DataManager, _ login: String) -> User? {
        source.users.first(where: { $0.login == login })
    }
}

//MARK: - Profile struct

struct Profile {
    let name: String
    let surname: String
    
    var fullname: String {
        "\(name) \(surname)"
    }
}

//MARK: - Profile static methods

extension Profile {
    static func getTestProfile() -> Profile {
        let dataSet = TestDataSet.shared
        return Profile(name: dataSet.testName,
                       surname: dataSet.testSurname)
    }
}
