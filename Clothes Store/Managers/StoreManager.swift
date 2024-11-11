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
    @Injected(\.coreDataManager) private var coreDataManager
    
    static let shared = StoreManager()
    
    @Published private(set) var wishlist: Set<Product> = []
    @Published private(set) var basket: [Product: Int] = [:]
    
    @Published var wishlistCount: Int = 0
    @Published var basketCount: Int = 0
    
    private(set) var products: [Product] = []
    
    private init() {
        loadWishlist()
        loadBasket()
    }
    
    var basketTotal: Float {
        basket.reduce(0) { $0 + (($1.key.price ?? 0) * Float($1.value)) }
    }
    
    private func loadWishlist() {
        wishlist = Set(coreDataManager.fetchWishlist())
        wishlistCount = wishlist.count
    }
    
    func addToWishlist(_ product: Product) -> Bool {
        let wasAdded = wishlist.insert(product).inserted
        if wasAdded {
            coreDataManager.saveProductToWishlist(product)
            wishlistCount = wishlist.count
        }
        return wasAdded
    }
    
    func removeFromWishlist(_ product: Product) {
        wishlist.remove(product)
        coreDataManager.removeProductFromWishlist(product)
        wishlistCount = wishlist.count
    }
    
    private func loadBasket() {
        let basketData = coreDataManager.fetchBasket()
        basket = Dictionary(uniqueKeysWithValues: basketData.map { ($0.product, $0.quantity) })
        basketCount = calculateBasketCount()
    }
    
    func addToBasket(_ product: Product) -> Bool {
        guard let stock = product.stock, stock > 0 else { return false }
        
        basket[product, default: 0] += 1
        coreDataManager.saveProductToBasket(product, quantity: basket[product]!)
        basketCount = calculateBasketCount()
        
        return true
    }
    
    func removeFromBasket(_ product: Product) {
        guard let currentQuantity = basket[product] else { return }
        
        if currentQuantity > 1 {
            basket[product] = currentQuantity - 1
            coreDataManager.saveProductToBasket(product, quantity: currentQuantity - 1)
        } else {
            basket.removeValue(forKey: product)
            coreDataManager.removeProductFromBasket(product)
        }
        
        basketCount = calculateBasketCount()
    }
    
    func setProducts(_ products: [Product]) {
        self.products = products
    }
    
    func getProduct(by productId: String) -> Product? {
        products.first { $0.productId == productId }
    }
    
    private func getProductIndex(by productId: String) -> Int? {
        products.firstIndex { $0.productId == productId }
    }

    private func calculateBasketCount() -> Int {
        basket.values.reduce(0, +)
    }
    
    private func updateStock(for product: Product, decrement: Bool) {
        guard let index = getProductIndex(by: product.productId) else { return }
        products[index].stock = (products[index].stock ?? 0) + (decrement ? -1 : 1)
    }
}
