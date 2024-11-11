//
//  CatalogueViewModel.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import SwiftUI
import Combine

class CatalogueViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil

    func fetchProducts() {
        isLoading = true
        DataService.getProducts { [weak self] products, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else if let productsData = products {
                    self?.products = productsData.products ?? []
                } else {
                    self?.errorMessage = "Unknown error occurred"
                }
            }
        }
    }
}
