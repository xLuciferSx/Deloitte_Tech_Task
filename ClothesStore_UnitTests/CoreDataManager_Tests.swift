//
//  CoreDataManager_Tests.swift
//  Clothes Store
//
//  Created by Raivis on 11/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

@testable import Clothes_Store
import XCTest

class CoreDataManager_Tests: XCTestCase {
    var mockCoreDataManager: MockCoreDataManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCoreDataManager = MockCoreDataManager()
    }

    override func tearDownWithError() throws {
        mockCoreDataManager = nil
        try super.tearDownWithError()
    }
    
    func testCreateOrFetchProductEntity() throws {
        let product = Product(productId: "1", name: "Test Product", category: .tops, price: 9.99, stock: 10, oldPrice: 12.99, image: "test_image")
        let productEntity = mockCoreDataManager.createOrFetchProductEntity(for: product)

        mockCoreDataManager.saveContext()
        
        XCTAssertEqual(productEntity.productId, "1")
        XCTAssertEqual(productEntity.name, "Test Product")
        XCTAssertEqual(productEntity.price, 9.99)
    }
    
    func testSaveProductToWishlist() throws {
        let product = Product(productId: "1", name: "Wishlist Product", category: .pants, price: 19.99, stock: 5, oldPrice: 25.99, image: "wishlist_image")
        
        mockCoreDataManager.saveProductToWishlist(product)
        
        let wishlist = mockCoreDataManager.fetchWishlist()
        XCTAssertEqual(wishlist.count, 1)
        XCTAssertEqual(wishlist.first?.productId, "1")
        XCTAssertEqual(wishlist.first?.name, "Wishlist Product")
    }

    func testRemoveProductFromWishlist() throws {
        let product = Product(productId: "1", name: "Wishlist Product", category: .pants, price: 19.99, stock: 5, oldPrice: 25.99, image: "wishlist_image")
        
        mockCoreDataManager.saveProductToWishlist(product)
        mockCoreDataManager.removeProductFromWishlist(product)
        
        let wishlist = mockCoreDataManager.fetchWishlist()
        XCTAssertTrue(wishlist.isEmpty)
    }

    func testSaveProductToBasket() throws {
        let product = Product(productId: "2", name: "Basket Product", category: .shoes, price: 29.99, stock: 3, oldPrice: 35.99, image: "basket_image")
        
        mockCoreDataManager.saveProductToBasket(product, quantity: 2)
        
        let basket = mockCoreDataManager.fetchBasket()
        XCTAssertEqual(basket.count, 1)
        XCTAssertEqual(basket.first?.product.productId, "2")
        XCTAssertEqual(basket.first?.quantity, 2)
    }

    func testRemoveProductFromBasket() throws {
        let product = Product(productId: "2", name: "Basket Product", category: .shoes, price: 29.99, stock: 3, oldPrice: 35.99, image: "basket_image")

        mockCoreDataManager.saveProductToBasket(product, quantity: 2)
        mockCoreDataManager.removeProductFromBasket(product)
        
        let basket = mockCoreDataManager.fetchBasket()
        XCTAssertTrue(basket.isEmpty)
    }

    func testFetchWishlist() throws {
        let product1 = Product(productId: "1", name: "Wishlist Product 1", category: .pants, price: 15.99, stock: 7, oldPrice: nil, image: "wishlist_image1")
        let product2 = Product(productId: "2", name: "Wishlist Product 2", category: .tops, price: 25.99, stock: 5, oldPrice: nil, image: "wishlist_image2")
        
        mockCoreDataManager.saveProductToWishlist(product1)
        mockCoreDataManager.saveProductToWishlist(product2)
        
        let wishlist = mockCoreDataManager.fetchWishlist()
        XCTAssertEqual(wishlist.count, 2)
        XCTAssertEqual(wishlist.map { $0.productId }, ["1", "2"])
    }

    func testFetchBasket() throws {
        let product1 = Product(productId: "1", name: "Basket Product 1", category: .pants, price: 20.00, stock: 5, oldPrice: 25.00, image: "basket_image1")
        let product2 = Product(productId: "2", name: "Basket Product 2", category: .shoes, price: 30.00, stock: 8, oldPrice: 35.00, image: "basket_image2")
        
        mockCoreDataManager.saveProductToBasket(product1, quantity: 1)
        mockCoreDataManager.saveProductToBasket(product2, quantity: 3)
        
        let basket = mockCoreDataManager.fetchBasket()
        XCTAssertEqual(basket.count, 2)
        XCTAssertEqual(basket[0].quantity, 1)
        XCTAssertEqual(basket[1].quantity, 3)
    }
}
