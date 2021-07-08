//
//  File.swift
//  ShoppingList
//
//  Created by cmStudent on 2021/07/08.
//

import Foundation
import RealmSwift

class RealmManager {
    // MARK: - Properties
    /// 初回アクセスのタイミングでインスタンス生成
    static let shared = RealmManager()
    /// realmのインスタンス
    let realm = try! Realm()
    
    func writeDB(DB: Object) {
        do{
            try realm.write{
                realm.add(DB)
            }
        }catch {
            print("Error \(error)")
        }
}
}
