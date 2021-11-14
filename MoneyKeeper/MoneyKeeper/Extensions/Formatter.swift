//
//  Formatter.swift
//  MoneyKeeper
//
//  Created by xubuntus on 14.11.2021.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    static let number = NumberFormatter()
}
