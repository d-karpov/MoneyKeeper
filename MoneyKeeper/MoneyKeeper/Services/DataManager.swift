//
//  DataManager.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

//MARK: - DataManager class

class DataManager {
    
    static let shared = DataManager()
    
    // MARK: Work data
    var users: [User]
    
    private init() {
        users = User.getTestUsers()
    }
}

// MARK: - TetsDataSingletone class

class TestDataSet {
    static let shared = TestDataSet()
    
    let testLogin = "User"
    let testPassword = "Password"
    let testName = "Den"
    let testSurname = ""
    let testAccountName = "Tinkoff"
    let testAccountMoney = 20000.0
    let startCategoriesNames = ["Salary", "Food", "Car", "Health"]
    
    private init() {}
}

