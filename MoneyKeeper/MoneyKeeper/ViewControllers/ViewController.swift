//
//  ViewController.swift
//  MoneyKeeper
//
//  Created by Денис Карпов on 13.11.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var accountName: UILabel!
    @IBOutlet var withdraw: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var income: UILabel!
    @IBOutlet var operations: UILabel!
    
    //Инизиализация доступа к хранилищу
    var dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Получение конкретного юзера
        guard var user = User.getUserByLogin(dataManager, "User") else { return }
        //Получение конкретного счета - НЕ ПРЕДНАЗНАЧЕН для внесения изменений
        guard let account = user.getAccountByName("Tinkoff") else { return }
        accountName.text = account.name
        //Изменения: добавление новой категории, добавление новой операции
        let newCategory = Category(name: "Party", type: .withdraw)
        user.addCategory(newCategory)
        user.addOperation(account.name, Operation(status: .active, category: newCategory, rawMoneyAmount: 4000))
        //Вывод балансов и операций с цифрой без знака по ним
        withdraw.text = String(user.getTotalWithdraw())
        total.text = String(user.getTotalMoneyAmount())
        income.text = String(user.getTotalIncome())
        operations.text = user.getAllActiveOperations().reduce("") {
            $0 + $1.category.name + " : " + String($1.rawMoneyAmount) + "\n"
        }
        //Сохранение данных в хранилище ОБЯЗАТЕЛЬНО после внесения изменений
        user.saveUserToDataManager(dataManager, user)
        
    }
}

