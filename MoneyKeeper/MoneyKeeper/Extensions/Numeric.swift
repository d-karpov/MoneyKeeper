//
//  Numeric.swift
//  MoneyKeeper
//
//  Created by xubuntus on 14.11.2021.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
    var currencyRU: String { formattedWithCurrency(style: .currency, locale: .russianRU) }
    
    func formattedWithCurrency(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        return Formatter.number.string(for: self) ?? ""
    }
}
