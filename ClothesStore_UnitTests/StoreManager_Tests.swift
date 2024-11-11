//
//  StoreManager_Tests.swift
//  ClothesStore_UnitTests
//
//  Created by Raivis on 11/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import XCTest
@testable import Clothes_Store

class StoreManager_Tests: XCTestCase {

    var mockStoreManager: MockStoreManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockStoreManager = MockStoreManager()
    }

    override func tearDownWithError() throws {
        mockStoreManager.resetMockData()
        mockStoreManager = nil
        try super.tearDownWithError()
    }
    
    func testAddToWishlist() throws {
        let product = Product(productId: "1", name: "Test Product", category: .tops, price: 10.0, stock: 5, oldPrice: nil, image: nil)
        
        let result = mockStoreManager.addToWishlist(product)
        
        XCTAssertTrue(result)
        XCTAssertEqual(mockStoreManager.wishlistCount, 1)
        XCTAssertTrue(mockStoreManager.wishlist.contains(product))
    }
    
    func testRemoveFromWishlist() throws {
        let product = Product(productId: "1", name: "Test Product", category: .tops, price: 10.0, stock: 5, oldPrice: nil, image: nil)
        
        mockStoreManager.addToWishlist(product)
        mockStoreManager.removeFromWishlist(product)
        
        XCTAssertEqual(mockStoreManager.wishlistCount, 0)
        XCTAssertFalse(mockStoreManager.wishlist.contains(product))
    }
    
    func testAddToBasket() throws {
        let product = Product(productId: "2", name: "Basket Product", category: .shoes, price: 20.0, stock: 10, oldPrice: nil, image: nil)
        
        let result = mockStoreManager.addToBasket(product)
        
        XCTAssertTrue(result)
        XCTAssertEqual(mockStoreManager.basketCount, 1)
        XCTAssertEqual(mockStoreManager.basket[product], 1)
    }
    
    func testRemoveFromBasket() throws {
        let product = Product(productId: "2", name: "Basket Product", category: .shoes, price: 20.0, stock: 10, oldPrice: nil, image: nil)
        
        mockStoreManager.addToBasket(product)
        mockStoreManager.addToBasket(product) // Add twice to increase quantity
        XCTAssertEqual(mockStoreManager.basket[product], 2)
        
        mockStoreManager.removeFromBasket(product)
        XCTAssertEqual(mockStoreManager.basket[product], 1)
        
        mockStoreManager.removeFromBasket(product)
        XCTAssertNil(mockStoreManager.basket[product]) // Should be removed from basket
        XCTAssertEqual(mockStoreManager.basketCount, 0)
    }
    
    func testBasketTotal() throws {
        let product1 = Product(productId: "1", name: "Product 1", category: .pants, price: 15.0, stock: 5, oldPrice: nil, image: nil)
        let product2 = Product(productId: "2", name: "Product 2", category: .shoes, price: 25.0, stock: 5, oldPrice: nil, image: nil)
        
        mockStoreManager.addToBasket(product1)
        mockStoreManager.addToBasket(product2)
        mockStoreManager.addToBasket(product2) // Add product2 twice
        
        XCTAssertEqual(mockStoreManager.basketTotal, 65.0) // 15 + (25 * 2)
    }
}
