//
//  CatalogueViewModel.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Combine
import SwiftUI
import Factory

class CatalogueViewModel: ObservableObject {
  @Injected(\.dataService) var dataService
  
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
    dataService.getProducts { [weak self] result in
      switch result {
      case .success(let productsData):
        self?.isLoading = false
        self?.products = productsData.products ?? []
        self?.filteredProducts = self?.products ?? []
      case .failure(let error):
        self?.isLoading = false
        self?.errorMessage = error.localizedDescription
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
