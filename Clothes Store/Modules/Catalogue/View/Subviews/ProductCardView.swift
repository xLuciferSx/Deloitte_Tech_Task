//
//  ProductCardView.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import SwiftUI
import Factory

struct ProductCardView: View {
    @Injected(\.storeManager) var storeManager
    
    @State private var isWishlisted: Bool = false
    
    let product: Product
    
    init(product: Product) {
        self.product = product
        _isWishlisted = State(initialValue: product.isWishlisted ?? false)
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = product.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 150, height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "placeholderImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image("placeholderImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
            }

            Text(product.name)
                .font(.body)
                .foregroundColor(.gray)

            if let price = product.price {
                Text("£\(String(format: "%.2f", price))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                .shadow(radius: 2)
        )
        .overlay(
            Button(action: toggleWishlist) {
                Image(systemName: isWishlisted ? "heart.fill" : "heart")
                    .foregroundColor(isWishlisted ? .red : .gray)
                    .padding(8)
            }
            .background(Color.white.opacity(0.7))
            .clipShape(Circle())
            .padding([.top, .trailing], 10),
            alignment: .topTrailing
        )
        .onAppear {
            isWishlisted = storeManager.wishlist.contains(product)
        }
    }
    
    private func toggleWishlist() {
        if isWishlisted {
            storeManager.removeFromWishlist(product)
        } else {
            _ = storeManager.addToWishlist(product)
        }
        isWishlisted.toggle()
    }
}
