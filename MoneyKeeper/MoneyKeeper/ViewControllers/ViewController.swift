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
    
    var dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Выбираем счет по индексу (нужно для обновления в DataManager)
        let index = dataManager.user.profile.getAccountIndex("Tinkoff")
        var account = dataManager.getAccount(index: index)
        // Добавляем операции по счету
        account.addOperation(Operation(status: .active,
                                       category: Category(name: "Car", type: .withdraw),
                                       rawMoneyAmount: 3567))
        account.addOperation(Operation(status: .active,
                                       category: Category(name: "Salary", type: .income),
                                       rawMoneyAmount: 2345))
        // Сохраняем изменения в DataManager
        dataManager.setAccount(index: index, updateAccount: account)
        
        //Выводим данные
        accountName.text = account.name //Название счета
        //Получаем все затраты по пользователю
        withdraw.text = String(dataManager.user.profile.getTotalWithdraw())
        //Получаем все доходы по пользователю
        income.text = String(dataManager.user.profile.getTotalIncome())
        //Получаем баланс по пользовалелб
        total.text = String(dataManager.user.profile.getTotalMoneyAmount())
        //Получаем все операции по пользователю (reduce только для вывода)
        operations.text = dataManager.user.profile.getAllActiveOperations().reduce("") {
            $0 + $1.category.name + ":" + String($1.rawMoneyAmount) + "\n"
        }
        
    }
}

