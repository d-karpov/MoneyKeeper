//
//  DataManager.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 14.11.2021.
//

import UIKit

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
    let testName = "User"
    let testSurname = "for test"
    let testAccountName = "Tinkoff"
    let testAccountMoney = 20000.0
    let startCategoriesNames = ["Salary", "Food", "Car", "Health"]
    
    private init() {}
}

//MARK: - Team Info
class TeamDataSet {
    
    static let shared = TeamDataSet()
    
    let names = ["Denis", "Nikita", "Ed"]
    let description = ["Model chief", "Screen lord", "Git guru"]
    
    private init() {}
}
