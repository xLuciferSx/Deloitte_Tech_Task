//
//  WishlistViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class WishlistViewController: UIViewController, BuyCellButtonTapped {
    // Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!

    // Variables
    var wishlistProducts: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadWishlist()
        NotificationCenter.default.addObserver(self, selector: #selector(loadWishlist), name: .wishlistUpdated, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func loadWishlist() {
        wishlistProducts = Array(StoreManager.shared.wishlist)
        tableView.reloadData()
        noProductsLabel.isHidden = !wishlistProducts.isEmpty
    }

    // MARK: - Actions

    func addProductToBasket(_ sender: SavedViewTableViewCell) {
        Haptic.feedBack()
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let product = wishlistProducts[indexPath.row]
        let success = StoreManager.shared.addToBasket(product)
        if success {
            StoreManager.shared.removeFromWishlist(product)
            loadWishlist()
            NotificationCenter.default.post(name: .basketUpdated, object: nil)
            showAlert(title: "Added to Basket", message: "\(product.name) has been added to your basket.")
        } else {
            showAlert(title: "Out of Stock", message: "This product is out of stock and cannot be added to the basket.")
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as? SavedViewTableViewCell else {
            fatalError("Unable to dequeue SavedViewTableViewCell")
        }

        let product = wishlistProducts[indexPath.row]
        cell.configureWithProduct(product: product)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completionHandler in
               guard let self = self else { return }

               Haptic.feedBack()

               let product = self.wishlistProducts[indexPath.row]
               
               StoreManager.shared.removeFromWishlist(product)
               
               self.wishlistProducts.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .automatic)
               self.noProductsLabel.isHidden = !self.wishlistProducts.isEmpty
               
               completionHandler(true)
           }

        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}
