
//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import SwiftUI

struct CatalogueView: View {
    @StateObject private var viewModel = CatalogueViewModel()
    @State private var selectedProduct: Product?
    @State private var isShowingDetailView = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.products, id: \.id) { product in
                                ProductCardView(product: product)
                                    .onTapGesture {
                                        selectedProduct = product
                                        isShowingDetailView = true
                                    }
                            }
                        }
                        .padding([.top, .bottom], 8)
                        .padding(.horizontal, 10)
                    }
                }
            }
            .navigationTitle("Catalogue")
            .onAppear {
                viewModel.fetchProducts()
            }
            .sheet(item: $selectedProduct) { product in
                DetailViewControllerRepresentable(product: product)
            }
        }
    }
}
