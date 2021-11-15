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
        guard let user = User.getUserFromDataManager(dataManager, "User") else { return }
        let index = user.profile.getAccountIndex("Tinkoff")
        // Добавляем операции по счету
//        account.addOperation(Operation(status: .active,
//                                       category: Category(name: "Car", type: .withdraw),
//                                       rawMoneyAmount: 3567))
//        account.addOperation(Operation(status: .active,
//                                       category: Category(name: "Salary", type: .income),
//                                       rawMoneyAmount: 2345))
//        account.addOperation(Operation(status: .active,
//                                       category: Category(name: "Salary", type: .income),
//                                       rawMoneyAmount: 1000))
        // Сохраняем изменения в DataManager
//        dataManager.setAccount(index: index, updateAccount: account)
        
        //Выводим данные
        accountName.text = user.profile.accounts[index].name //Название счета
        //Получаем все затраты по пользователю
        withdraw.text = String(user.profile.getTotalWithdraw())
        //Получаем все доходы по пользователю
        income.text = String(user.profile.getTotalIncome())
        //Получаем баланс по пользовалелб
        total.text = String(user.profile.getTotalMoneyAmount())
        //Получаем все операции по пользователю (reduce только для вывода)
        operations.text = user.profile.getAllActiveOperations().reduce("") {
            $0 + $1.category.name + ":" + String($1.rawMoneyAmount) + "\n"
        }
        
    }
}

