//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Factory
import UIKit

protocol DetailViewContainerDelegate: AnyObject {
    func didCloseDetailView()
}

class DetailViewContainerViewController: UIViewController {
    @Injected(\.storeManager) var storeManager

    // Views
    var backButton: UIBarButtonItem!
    @IBOutlet var wishListButton: UIButton!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var addedToWishlistLabel: UILabel!
    @IBOutlet var addedToBasketLabel: UILabel!

    // Variables
    var product: Product!
    weak var delegate: DetailViewContainerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }

    func setUpButtons() {
        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }

    func updateUI() {
        let isInWishlist = storeManager.wishlist.contains(product)
        addedToWishlistLabel.isHidden = !isInWishlist

        let isInBasket = storeManager.basket[product] != nil
        addedToBasketLabel.isHidden = !isInBasket
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailContainer" {
            let dest = segue.destination as! ProductDetailTableViewController
            dest.product = product
        }
    }

    // MARK: - Actions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addToCartAction(_ sender: Any) {
        Haptic.feedBack()
        let success = storeManager.addToBasket(product)
        if success {
            addedToBasketLabel.isHidden = false
            addedToWishlistLabel.isHidden = true
            storeManager.removeFromWishlist(product)
            NotificationCenter.default.post(name: .basketUpdated, object: nil)
            showAlert(
                title: "added_to_basket_title".localized,
                message: String(format: "added_to_basket_message".localized, product.name)
            )
        } else {
            showAlert(
                title: "out_of_stock_title".localized,
                message: "out_of_stock_message".localized
            )
        }
    }

    @IBAction func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        let success = storeManager.addToWishlist(product)
        if success {
            addedToWishlistLabel.isHidden = false
            showAlert(
                title: "added_to_wishlist_title".localized,
                message: String(format: "added_to_wishlist_message".localized, product.name)
            )
            NotificationCenter.default.post(name: .wishlistUpdated, object: nil)
        } else {
            showAlert(
                title: "already_in_wishlist_title".localized,
                message: String(format: "already_in_wishlist_message".localized, product.name)
            )
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
