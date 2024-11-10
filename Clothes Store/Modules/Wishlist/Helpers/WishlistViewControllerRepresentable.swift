//
//  WishlistViewControllerRepresentable.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import SwiftUI

struct WishlistViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> WishlistViewController {
        let viewController: WishlistViewController = UIStoryboard.instantiateViewController(from: .wishlist, identifier: .wishlistViewController)
        return viewController
    }

    func updateUIViewController(_ uiViewController: WishlistViewController, context: Context) {}
}

