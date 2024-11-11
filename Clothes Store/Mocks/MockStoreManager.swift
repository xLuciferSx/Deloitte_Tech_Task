//
//  MockStoreManager.swift
//  Clothes Store
//
//  Created by Raivis on 11/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Combine
import Foundation

class MockStoreManager: ObservableObject {
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
    
    func addToWishlist(_ product: Product) -> Bool {
        let added = wishlist.insert(product).inserted
        if added {
            wishlistCount = wishlist.count
        }
        return added
    }
    
    func removeFromWishlist(_ product: Product) {
        wishlist.remove(product)
        wishlistCount = wishlist.count
    }
    
    func addToBasket(_ product: Product) -> Bool {
        guard let stock = product.stock, stock > 0 else { return false }
        
        if let quantity = basket[product] {
            basket[product] = quantity + 1
        } else {
            basket[product] = 1
        }
        basketCount = basket.values.reduce(0, +)
        return true
    }
    
    func removeFromBasket(_ product: Product) {
        if let quantity = basket[product], quantity > 1 {
            basket[product] = quantity - 1
        } else {
            basket.removeValue(forKey: product)
        }
        basketCount = basket.values.reduce(0, +)
    }
    
    func loadWishlist() {
        wishlistCount = wishlist.count
    }
    
    func loadBasket() {
        basketCount = basket.values.reduce(0, +)
    }
    
    func resetMockData() {
        wishlist = []
        basket = [:]
        wishlistCount = 0
        basketCount = 0
    }
}
