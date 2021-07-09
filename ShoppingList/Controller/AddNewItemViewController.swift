//
//  AddNewItemViewController.swift
//  ShoppingList
//
//  Created by naoki-mrnk on 2021/07/08.
//

import UIKit
import RealmSwift

class AddNewItemViewController: UIViewController {
    // MARK: - Properties
    let realmManager = RealmManager.shared
    var items: Results<Item>!
    
    // MARK: - IBOutlet
    @IBOutlet private weak var itemListTableView: UITableView!
    @IBOutlet weak var inputNewItemTextField: UITextField!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
        
        items = realmManager.realm.objects(Item.self)
        itemListTableView.reloadData()
    }
    
    // MARK: - IBAction
    @IBAction func tappedAddItemButton(_ sender: UIButton) {
        let itemIsEmpty = inputNewItemTextField.text?.isEmpty ?? false
        if itemIsEmpty {
            
        } else {
            let itemName = inputNewItemTextField.text!
            let item = Item()
            try! realmManager.realm.write {
                item.itemName = itemName
            }
            realmManager.writeDB(DB: item)
            
            let shoppingItem = ShoppingItem()
            try! realmManager.realm.write {
                shoppingItem.itemID = item.itemID
                shoppingItem.createAt = Date()
            }
            realmManager.writeDB(DB: shoppingItem)
        }
        itemListTableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - extension
extension AddNewItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items  else { return 0 }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "itemCell")
        let object = items[indexPath.row]
        cell.textLabel!.text = object.itemName
        
        return cell
    }
}

extension AddNewItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
