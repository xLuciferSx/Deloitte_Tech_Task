//
//  BasketViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit
import Factory

class BasketViewController: UIViewController {
    @Injected(\.storeManager) var storeManager
    // Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var checkoutButton: UIButton!

    // Variables
    var basketItems: [Product] = []
    var basketQuantities: [Product: Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadBasket()
        setupNotifications()
        checkoutButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadBasket), name: .basketUpdated, object: nil)
    }

    @objc func loadBasket() {
        basketItems = Array(storeManager.basket.keys)
        basketQuantities = storeManager.basket
        tableView.reloadData()
        noProductsLabel.isHidden = !basketItems.isEmpty
        updateTotal()
    }

    func updateTotal() {
        let totalCost = storeManager.basketTotal
        total.text = "total_cost".localized(with: CurrencyHelper.getMoneyString(totalCost))
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as? BasketViewTableViewCell else {
            fatalError("Unable to dequeue BasketViewTableViewCell")
        }

        let product = basketItems[indexPath.row]
        let quantity = basketQuantities[product] ?? 1
        cell.configureWithProduct(product: product, quantity: quantity)
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
        let deleteAction = UIContextualAction(style: .destructive, title: "remove".localized) { [weak self] _, _, completion in
            guard let self = self else { return }
            let product = self.basketItems[indexPath.row]
            storeManager.removeFromBasket(product)
            self.loadBasket()
            Haptic.feedBack()
            completion(true)
        }

        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}

extension BasketViewController: BasketCellDelegate {
    func didTapPlus(for product: Product) {
        _ = storeManager.addToBasket(product)
        loadBasket()
    }

    func didTapMinus(for product: Product) {
        storeManager.removeFromBasket(product)
        loadBasket()
    }
}
