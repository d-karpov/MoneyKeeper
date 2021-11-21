//
//  UserExtension.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 17.11.2021.
//

import UIKit

//MARK: - User public methods
extension User {
    
    func getIncludedAccounts() -> [Account] {
        profile.accounts.filter { $0.status == .included }
    }
    
    func getTotalMoneyAmount() -> Double {
        getIncludedAccounts().reduce(0.0) { $0 + $1.moneyAmount }
    }
    
    func getTotalWithdraw() -> Double {
        getIncludedAccounts().reduce(0.0) { $0 + $1.getMoneyAmount(.withdraw) }
    }
    
    func getTotalIncome() -> Double {
        getIncludedAccounts().reduce(0.0) { $0 + $1.getMoneyAmount(.income) }
    }
    
    func getTotalInCategory( _ category: Category ) -> Double {
        getIncludedAccounts().reduce(0.0) { $0 + $1.getMoneyAmount(category) }
    }

    func getAllActiveOperations() -> [Operation] {
        getIncludedAccounts().flatMap { $0.getActiveOperations() }
    }
    
    func getAllOperationsByCattegory(_ categoryName: String) -> [Operation] {
        getAllActiveOperations().filter { $0.category.name == categoryName }
    }
    
    func getAllOperationsByAccount(_ accountName: String) -> [Operation] {
        if let accountIndex = profile.accounts.firstIndex(where: { $0.name == accountName }) {
            return profile.accounts[accountIndex].getActiveOperations()
        }
        return []
    }
    
    func getMonthlyAllOperations() -> [Operation] {
        return getAllActiveOperations().filter { $0.compareDateWithNow() }
    }
    
    func getMonthlyOperationsByAccount(_ accountName: String) -> [Operation] {
        let allOperations = getAllOperationsByAccount(accountName)
        return allOperations.filter { $0.compareDateWithNow() }
    }
    
    func getMonthlyOperationsByCategory(_ categoryName: String) -> [Operation] {
        let allOperations = getAllOperationsByCattegory(categoryName)
        return allOperations.filter { $0.compareDateWithNow() }
    }
    
    func getAllCategoriesByType(_ type: CategoriesTypes) -> [Category] {
        profile.categories.filter { $0.type == type }
    }
    
    func getAccountByName (_ name: String) -> Account? {
        profile.accounts.first { $0.name == name }
    }
    
    func accountIsExist(_ name: String) -> Bool {
        getAccountByName(name) != nil
    }
    
//MARK: - Mutating methods
    mutating func addCategory(_ newCategory: Category) {
        if !profile.categories.contains(where: { $0 == newCategory }) {
            profile.categories.append(newCategory)
        }
    }
        
    mutating func addOperation(_ toAccount: String, _ newOperation: Operation) {
        guard let index = getAccountIndex(toAccount) else { return }
        profile.accounts[index].addOperation(newOperation)
    }
    
    mutating func addAccount(_ newAccount: Account) {
        profile.accounts.append(newAccount)
    }
    
//MARK: - Save User to DataManager method
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
