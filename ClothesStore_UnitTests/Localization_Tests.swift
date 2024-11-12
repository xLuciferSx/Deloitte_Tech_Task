//
//  Localization_Tests.swift
//  ClothesStore_UnitTests
//
//  Created by Raivis on 12/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Testing
@testable import Clothes_Store

@MainActor
class LocalizationTests {
    @Test("Verify simple localization keys return correct localized strings")
    func testSimpleLocalizationKeys() {
        #expect("product_name".localized == "Product Name", "The 'product_name' key did not return the expected localized string.")
        #expect("price".localized == "Price", "The 'price' key did not return the expected localized string.")
        #expect("remove".localized == "Remove", "The 'remove' key did not return the expected localized string.")
        #expect("catalogue_title".localized == "Catalogue", "The 'catalogue_title' key did not return the expected localized string.")
        #expect("search_placeholder".localized == "Search for products...", "The 'search_placeholder' key did not return the expected localized string.")
        #expect("loading_text".localized == "Loading...", "The 'loading_text' key did not return the expected localized string.")
        #expect("error_prefix".localized == "Error:", "The 'error_prefix' key did not return the expected localized string.")
        #expect("generic_error_message".localized == "Something went wrong!", "The 'generic_error_message' key did not return the expected localized string.")
        #expect("added_to_basket_title".localized == "Added to Basket", "The 'added_to_basket_title' key did not return the expected localized string.")
        #expect("out_of_stock_title".localized == "Out of Stock", "The 'out_of_stock_title' key did not return the expected localized string.")
        #expect("added_to_wishlist_title".localized == "Added to Wishlist", "The 'added_to_wishlist_title' key did not return the expected localized string.")
        #expect("already_in_wishlist_title".localized == "Already in Wishlist", "The 'already_in_wishlist_title' key did not return the expected localized string.")
        #expect("ok_button".localized == "OK", "The 'ok_button' key did not return the expected localized string.")
    }

    @Test("Verify formatted localization keys return correct localized strings with dynamic values")
    func testFormattedLocalizationKeys() {
        #expect("added_to_wishlist".localized(with: "Product A") == "Product A has been added to your wishlist.", "The formatted 'added_to_wishlist' key did not return the expected string.")
        #expect("removed_from_wishlist".localized(with: "Product A") == "Product A has been removed from your wishlist.", "The formatted 'removed_from_wishlist' key did not return the expected string.")
        #expect("total_cost".localized(with: "£100") == "Total Cost: £100", "The formatted 'total_cost' key did not return the expected string.")
        #expect("added_to_basket_message".localized(with: "Product B") == "Product B has been added to your basket.", "The formatted 'added_to_basket_message' key did not return the expected string.")
        #expect("out_of_stock_message".localized == "This product is out of stock and cannot be added to the basket.", "The 'out_of_stock_message' key did not return the expected localized string.")
        #expect("added_to_wishlist_message".localized(with: "Product C") == "Product C has been added to your wishlist.", "The formatted 'added_to_wishlist_message' key did not return the expected string.")
        #expect("already_in_wishlist_message".localized(with: "Product D") == "Product D is already in your wishlist.", "The formatted 'already_in_wishlist_message' key did not return the expected string.")
    }
    
    @Test("Verify missing localization key returns the key itself")
    func testMissingLocalizationKey() {
        #expect("missing_key".localized == "missing_key", "A missing localization key should return the key itself.")
    }
}
