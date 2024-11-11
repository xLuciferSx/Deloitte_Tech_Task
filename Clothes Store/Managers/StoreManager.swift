//
//  StoreManager.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Combine
import Foundation
import Factory

class StoreManager: ObservableObject {
    @Injected(\.coreDataManager) var coreDataManager
    
    static let shared = StoreManager()
    
    private init() {
        loadWishlist()
        loadBasket()
    }
    
    @Published private(set) var wishlist: Set<Product> = []
    @Published private(set) var basket: [Product: Int] = [:]
    
    @Published var wishlistCount: Int = 0
    @Published var basketCount: Int = 0
    
    var basketTotal: Float {
        return basket.reduce(0) { result, item -> Float in
            let (product, quantity) = item
            return result + (product.price ?? 0) * Float(quantity)
        }
    }
    
    private func loadWishlist() {
        wishlist = Set(coreDataManager.fetchWishlist())
        wishlistCount = wishlist.count
    }
    
    private func loadBasket() {
        let basketData = coreDataManager.fetchBasket()
        basket = Dictionary(uniqueKeysWithValues: basketData.map { ($0.product, $0.quantity) })
        basketCount = basket.values.reduce(0, +)
    }
    
    func addToWishlist(_ product: Product) -> Bool {
        let added = wishlist.insert(product).inserted
        if added {
            coreDataManager.saveProductToWishlist(product)
            updateCounts()
        }
        return added
    }
    
    func removeFromWishlist(_ product: Product) {
        wishlist.remove(product)
        coreDataManager.removeProductFromWishlist(product)
        updateCounts()
    }
    
    func addToBasket(_ product: Product) -> Bool {
        guard let stock = product.stock, stock > 0 else {
            return false
        }

        if let quantity = basket[product] {
            basket[product] = quantity + 1
        } else {
            basket[product] = 1
        }
        coreDataManager.saveProductToBasket(product, quantity: basket[product]!)
        updateCounts()
        return true
    }
    
    func removeFromBasket(_ product: Product) {
        if let quantity = basket[product], quantity > 1 {
            basket[product] = quantity - 1
            coreDataManager.saveProductToBasket(product, quantity: basket[product]!)
        } else {
            basket.removeValue(forKey: product)
            coreDataManager.removeProductFromBasket(product)
        }
        updateCounts()
    }
    
    private func updateStock(for product: Product, decrement: Bool) {
        guard let index = getProductIndex(by: product.productId) else { return }
        if decrement {
            products[index].stock = (products[index].stock ?? 1) - 1
        } else {
            products[index].stock = (products[index].stock ?? 0) + 1
        }
    }
    
    private(set) var products: [Product] = []
    
    func setProducts(_ products: [Product]) {
        self.products = products
    }
    
    func getProduct(by productId: String) -> Product? {
        return products.first(where: { $0.productId == productId })
    }
    
    private func getProductIndex(by productId: String) -> Int? {
        return products.firstIndex(where: { $0.productId == productId })
    }
    
    private func updateCounts() {
        wishlistCount = wishlist.count
        basketCount = basket.values.reduce(0, +)
        NotificationCenter.default.post(name: .basketUpdated, object: nil)
    }
}
