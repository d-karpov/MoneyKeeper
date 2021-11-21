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

//MARK: - User static methods
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
