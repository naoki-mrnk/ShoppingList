//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by naoki-mrnk on 2021/07/08.
//

import UIKit

class ShoppingListViewController: UIViewController {

    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var shoppingListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.settingButton()
    }
    
    
    @IBAction func tappedAddButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddNewItem", sender: nil)
    }
}
