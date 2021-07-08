//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by naoki-mrnk on 2021/07/08.
//

import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController {
    
    // MARK: - Properties
    let realmManager = RealmManager.shared
    var items: Results<Item>!
    var shoppingItems: Results<ShoppingItem>!
    
    // MARK: - IBOutlet
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var shoppingListTableView: UITableView!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.settingButton()
        
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        shoppingItems = realmManager.realm.objects(ShoppingItem.self).filter("boughtAt == nil")
        shoppingListTableView.reloadData()
        
        print(realmManager.realm.objects(ShoppingItem.self))
        print(realmManager.realm.objects(Item.self))
    }
    
    
    @IBAction func tappedAddButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddNewItem", sender: nil)
    }
}

// MARK: - extension
extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let shoppingItems = shoppingItems else { return 0 }
        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let object = shoppingItems[indexPath.row]
        let item = realmManager.realm.object(ofType: Item.self, forPrimaryKey: object.itemID)
        cell.textLabel!.text = item?.itemName
        let nowDate = object.createAt.getDate()!
        cell.detailTextLabel?.text = "追加日: \(nowDate)"
        
        return cell
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let shoppingItem = shoppingItems[indexPath.row]
            try! realmManager.realm.write {
                
                shoppingItem.boughtAt = Date()
                print(shoppingItem.boughtAt!)
            }

            shoppingListTableView.reloadData()
        }
    }
}
