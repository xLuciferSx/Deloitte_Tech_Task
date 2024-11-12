//
//  CatalogueViewModel.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Combine
import SwiftUI

class CatalogueViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchQuery: String = ""
    @Published private(set) var filteredProducts: [Product] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSearchBinding()
    }

    func fetchProducts() {
        isLoading = true
        DataService.getProducts { [weak self] products, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else if let productsData = products {
                    self?.products = productsData.products ?? []
                    self?.filteredProducts = self?.products ?? []
                } else {
                    self?.errorMessage = "generic_error_message".localized
                }
            }
        }
    }

    private func setupSearchBinding() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($products)
            .map { query, products in
                products.filter { product in
                    query.isEmpty || product.name.localizedCaseInsensitiveContains(query)
                }
            }
            .assign(to: &$filteredProducts)
    }
}
