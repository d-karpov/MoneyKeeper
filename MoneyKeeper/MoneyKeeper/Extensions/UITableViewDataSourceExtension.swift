//
//  UITableViewDataSourceExtension.swift
//  MoneyKeeper
//
//  Created by xubuntus on 20.11.2021.
//

import UIKit

extension UITableViewDataSource {
    func string(ofDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: ofDate)
    }
    
    func getUniqueDates(ofOperationArray: [Operation]) -> [String] {
        var uniqueDates: [String] = []
        ofOperationArray.sorted(by: {$0.date > $1.date}).forEach {
            uniqueDates.append(string(ofDate: $0.date))
        }
        
        return uniqueDates.uniqued()
    }
}
