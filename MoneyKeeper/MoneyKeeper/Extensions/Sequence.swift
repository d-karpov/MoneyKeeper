//
//  Sequence.swift
//  MoneyKeeper
//
//  Created by xubuntus on 17.11.2021.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
