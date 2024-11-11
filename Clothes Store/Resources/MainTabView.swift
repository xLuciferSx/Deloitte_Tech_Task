//
//  MainTabView.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Combine
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @ObservedObject private var storeManager = StoreManager.shared

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CatalogueView()
                    .tabItem {
                        VStack {
                            Image(systemName: "books.vertical.fill")
                            Text("Catalogue")
                        }
                    }
                    .tag(0)

                Group {
                    WishlistViewControllerRepresentable()
                        .ignoresSafeArea()
                        .tabItem {
                            VStack {
                                Image(systemName: "heart")
                                Text("Wishlist")
                            }
                        }
                        .badge(storeManager.wishlistCount)
                        .tag(1)
                }

                Group {
                    BasketViewControllerRepresentable()
                        .ignoresSafeArea()
                        .tabItem {
                            VStack {
                                Image(systemName: "cart")
                                Text("Basket")
                            }
                        }
                        .badge(storeManager.basketCount)
                        .tag(2)
                }
            }
            .accentColor(.red)
            .background(Color.clear)
            .onAppear {
                UITabBar.appearance().backgroundColor = UIColor.systemGray6
            }
        }
        .background(
            Color.white
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: -5)
        )
    }
}
