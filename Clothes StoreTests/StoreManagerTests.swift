////
////  StoreManagerTests.swift
////  Clothes Store
////
////  Created by Raivis on 10/11/2024.
////  Copyright © 2024 RichieHope. All rights reserved.
////
//
//import XCTest
//@testable import Clothes_Store
//
//class StoreManagerTests: XCTestCase {
//    
//    var storeManager: StoreManager!
//    var product1: Product!
//    var product2: Product!
//    
//    override func setUp() {
//        super.setUp()
//        
//        // Initialize StoreManager and Product instances
//        storeManager = StoreManager.shared
//        storeManager.setProducts([])
//        storeManager.clearWishlist()
//        storeManager.clearBasket()
//        
//        // Sample products
//        product1 = Product(
//            productId: "1",
//            name: "Blue Pants",
//            category: .pants,
//            price: 9.99,
//            stock: 5,
//            oldPrice: nil,
//            image: nil
//        )
//        
//        product2 = Product(
//            productId: "2",
//            name: "Green Shirt",
//            category: .tops,
//            price: 15.99,
//            stock: 10,
//            oldPrice: nil,
//            image: nil
//        )
//    }
//    
//    override func tearDown() {
//        // Clean up after each test
//        storeManager.clearWishlist()
//        storeManager.clearBasket()
//        storeManager = nil
//        product1 = nil
//        product2 = nil
//        
//        super.tearDown()
//    }
//
//    func testAddToWishlist() {
//        // Test adding a product to the wishlist
//        XCTAssertTrue(storeManager.addToWishlist(product1))
//        XCTAssertEqual(storeManager.wishlistCount, 1)
//        
//        // Test adding the same product again (should return false)
//        XCTAssertFalse(storeManager.addToWishlist(product1))
//        XCTAssertEqual(storeManager.wishlistCount, 1) // Count should remain 1
//    }
//
//    func testRemoveFromWishlist() {
//        // Add and then remove a product
//        storeManager.addToWishlist(product1)
//        XCTAssertEqual(storeManager.wishlistCount, 1)
//        
//        storeManager.removeFromWishlist(product1)
//        XCTAssertEqual(storeManager.wishlistCount, 0)
//    }
//    
//    func testAddToBasket() {
//        // Test adding a product to the basket
//        XCTAssertTrue(storeManager.addToBasket(product1))
//        XCTAssertEqual(storeManager.basketCount, 1)
//        
//        // Add the same product again (should increase the count in basket)
//        XCTAssertTrue(storeManager.addToBasket(product1))
//        XCTAssertEqual(storeManager.basketCount, 2)
//        
//        // Test adding a second product
//        XCTAssertTrue(storeManager.addToBasket(product2))
//        XCTAssertEqual(storeManager.basketCount, 3) // Total items in basket
//    }
//    
//    func testRemoveFromBasket() {
//        // Add items to the basket
//        storeManager.addToBasket(product1)
//        storeManager.addToBasket(product1) // Two of product1
//        storeManager.addToBasket(product2) // One of product2
//        
//        XCTAssertEqual(storeManager.basketCount, 3)
//        
//        // Remove one quantity of product1
//        storeManager.removeFromBasket(product1)
//        XCTAssertEqual(storeManager.basketCount, 2)
//        
//        // Remove product1 entirely
//        storeManager.removeFromBasket(product1)
//        XCTAssertEqual(storeManager.basketCount, 1)
//        
//        // Remove the last item (product2)
//        storeManager.removeFromBasket(product2)
//        XCTAssertEqual(storeManager.basketCount, 0)
//    }
//    
//    func testBasketTotalCalculation() {
//        // Set specific prices and add items to the basket
//        product1.price = 10.0
//        product2.price = 20.0
//        
//        storeManager.addToBasket(product1)
//        storeManager.addToBasket(product1) // 2 x product1 = 20.0
//        storeManager.addToBasket(product2) // 1 x product2 = 20.0
//        
//        XCTAssertEqual(storeManager.basketTotal, 40.0)
//    }
//}
