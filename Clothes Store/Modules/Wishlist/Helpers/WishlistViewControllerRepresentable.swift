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
        let storyboard = UIStoryboard(name: "Wishlist", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "WishlistViewController") as? WishlistViewController else {
            fatalError("WishlistViewController not found in Wishlist storyboard")
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: WishlistViewController, context: Context) {}
}

