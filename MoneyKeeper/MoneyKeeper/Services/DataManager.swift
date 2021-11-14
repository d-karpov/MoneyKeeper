//
//  DataManager.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

class DataManager {
    
    static let shared = DataManager()
    
    // MARK: Work data
    var user: User
    
    private init() {
        user = User.getTestUsers()[0]
    }
}

extension DataManager {
    func getAccount(index: Int) -> Account {
        user.profile.accounts[index]
    }
    
    func setAccount(index: Int, updateAccount: Account) {
        user.profile.accounts[index] = updateAccount
    }
}

class TestDataSet {
    static let shared = TestDataSet()
    
    // MARK: Tets data
    let testLogin = "User"
    let testPassword = "Password"
    let testName = "Den"
    let testSurname = ""
    let testAccountName = "Tinkoff"
    let testAccountMoney = 20000.0
    let startCategoriesNames = ["Slary", "Food", "Car", "Health"]
    
    private init() {}
}

