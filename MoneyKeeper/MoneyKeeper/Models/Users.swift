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
}

//MARK: - User public methods

extension User {
    func getTotalMoneyAmount() -> Double {
        profile.accounts.reduce(0.0) { $0 + $1.moneyAmount }
    }
    
    func getTotalWithdraw() -> Double {
        profile.accounts.reduce(0.0) { $0 + $1.getMoneyAmount(.withdraw) }
    }
    
    func getTotalIncome() -> Double {
        profile.accounts.reduce(0.0) { $0 + $1.getMoneyAmount(.income) }
    }
    
    func getAllActiveOperations() -> [Operation] {
        profile.accounts.flatMap { $0.getActiveOperations() }
    }
    
    func getTotalInCategory( _ name: String ) -> Double {
        profile.accounts.reduce(0.0) { $0 + $1.getMoneyAmount(name)}
    }
    
    func getAllCategoriesByType(_ type: CategoriesTypes) -> [Category] {
        profile.categories.filter { $0.type == type }
    }
    
    func getAccountByName (_ name: String) -> Account? {
        profile.accounts.first { $0.name == name }
    }
    //MARK: - Mutating methods
    
    mutating func addCategory(_ newCategory: Category) {
        if !profile.categories.contains(where: {$0 == newCategory}) {
            profile.categories.append(newCategory)
        }
    }
        
    mutating func addOperation(_ toAccount: String, _ newOperation: Operation) {
        guard let index = getAccountIndex(toAccount) else { return }
        profile.accounts[index].addOperation(newOperation)
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
        profile.accounts.firstIndex(where: { $0.name == name })
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
                     profile: Profile.getTestProfile())]
    }
    
    static func getUserByLogin(_ source: DataManager, _ login: String) -> User? {
        source.users.first(where: { $0.login == login })
    }
}

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
