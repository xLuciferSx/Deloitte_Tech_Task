//
//  MainTabView.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var wishlistCount: Int = 3
    @State private var basketCount: Int = 3

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
                    if wishlistCount > 0 {
                        CatalogueView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "heart")
                                    Text("Wishlist")
                                }
                            }
                            .badge(wishlistCount)
                            .tag(1)
                    } else {
                        CatalogueView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "heart")
                                    Text("Wishlist")
                                }
                            }
                            .tag(1)
                    }
                }

                Group {
                    if basketCount > 0 {
                        CatalogueView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "cart")
                                    Text("Basket")
                                }
                            }
                            .badge(basketCount)
                            .tag(2)
                    } else {
                        CatalogueView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "cart")
                                    Text("Basket")
                                }
                            }
                            .tag(2)
                    }
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

#Preview {
    MainTabView()
}
