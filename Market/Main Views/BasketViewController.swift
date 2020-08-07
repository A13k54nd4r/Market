//
//  BasketViewController.swift
//  Market
//
//  Created by Aleksandar Savić on 13.06.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import UIKit
import JGProgressHUD
class BasketViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var basketTotalPriceLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButtonOutlet: UIButton!
    
    //MARK: Vars
    var basket: Basket?
    var allItems: [Item] = []
    var purchasedItemIds : [String] = []
    let hud = JGProgressHUD(style: .dark)
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = footerView
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //TODO: check if user is logged in
        loadBasketFromFirestore()
    }
    
    //MARK: IBActions
    @IBAction func checkoutButtonPressed(_ sender: Any) {
    }
    
    //MARK: Download Basket
    private func loadBasketFromFirestore() {
        downloadBasketFromFirestore("1234") { (basket) in
            self.basket = basket
            self.getBasketItems()
        }
    }
    private func getBasketItems() {
        if basket != nil {
            downloadItems(basket!.itemIds) { (allItems) in
                self.allItems = allItems
                self.updateTotalLabels(false)
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Helper Functions
    private func updateTotalLabels(_ isEmpty: Bool) {
        if isEmpty {
            totalItemsLabel.text = "0"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        } else {
            totalItemsLabel.text = "\(allItems.count)"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        }
        checkoutButtonStatusUpdate()
        
    }
    private func returnBasketTotalPrice() -> String {
        var totalPrice = 0.0
        for item in allItems {
            totalPrice += item.price
        }
        return "Total price: " + convertToCurrency(totalPrice)
    }
    
    //MARK: Navigation
    private func showItemView(withItem: Item) {
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemView") as! ItemViewController
        itemVC.item = withItem
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    //MARK: Control CheckoutButton
    private func checkoutButtonStatusUpdate() {
        checkoutButtonOutlet.isEnabled = allItems.count > 0
        if checkoutButtonOutlet.isEnabled {
            checkoutButtonOutlet.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        } else {
            disableCheckoutButton()
        }
    }
    private func disableCheckoutButton() {
        checkoutButtonOutlet.isEnabled = false
        checkoutButtonOutlet.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    private func removeItemFromBasket(itemId: String) {
        for i in 0..<basket!.itemIds.count {
            if itemId == basket!.itemIds[i] {
                basket!.itemIds.remove(at: i)
                return
            }
        }
    }
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.generateCell(allItems[indexPath.row])
        return cell
    }
    
    //MARK: UITableview Delegate
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = allItems[indexPath.row]
            allItems.remove(at: indexPath.row)
            tableView.reloadData()
            removeItemFromBasket(itemId: itemToDelete.id)
            updateBasketInFirestore(basket!, withValues: [kITEMIDS : basket!.itemIds]) { (error) in
                if error != nil {
                    print("error updating the basket", error!.localizedDescription)
                }
                self.getBasketItems()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(withItem: allItems[indexPath.row])
    }
    
}

