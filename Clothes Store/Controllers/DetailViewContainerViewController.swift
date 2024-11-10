//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

protocol DetailViewContainerDelegate: AnyObject {
    func didCloseDetailView()
}

class DetailViewContainerViewController: UIViewController{

    //Views
    var backButton : UIBarButtonItem!
    @IBOutlet var wishListButton: UIButton!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var addedToWishlistLabel: UILabel!
    @IBOutlet var addedToBasketLabel: UILabel!

    //Variables
    var product : Product!
    weak var delegate: DetailViewContainerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }
    
    func setUpButtons(){

        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }
    
    func updateUI() {
        let isInWishlist = StoreManager.shared.wishlist.contains(product)
        addedToWishlistLabel.isHidden = !isInWishlist

        let isInBasket = StoreManager.shared.basket[product] != nil
        addedToBasketLabel.isHidden = !isInBasket
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailContainer"{
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
        let success = StoreManager.shared.addToBasket(product)
        if success {
            addedToBasketLabel.isHidden = false
            addedToWishlistLabel.isHidden = true
            StoreManager.shared.removeFromWishlist(product)
            NotificationCenter.default.post(name: .basketUpdated, object: nil)
            showAlert(title: "Added to Basket", message: "\(product.name) has been added to your basket.")
        } else {
            showAlert(title: "Out of Stock", message: "This product is out of stock and cannot be added to the basket.")
        }
    }

    @IBAction func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        let success = StoreManager.shared.addToWishlist(product)
        if success {
            addedToWishlistLabel.isHidden = false
            showAlert(title: "Added to Wishlist", message: "\(product.name) has been added to your wishlist.")
            NotificationCenter.default.post(name: .wishlistUpdated, object: nil)
        } else {
            showAlert(title: "Already in Wishlist", message: "\(product.name) is already in your wishlist.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

