//
//  getDate.swift
//  ShoppingList
//
//  Created by naoki-mrnk on 2021/07/08.
//

import Foundation

extension Date {
    func getDate() -> String? {
        let f = DateFormatter()
        f.dateStyle = .short
        f.locale = Locale(identifier: "ja_JP") as Locale
        let nowDate = f.string(from: self)
        return nowDate
    }
}
