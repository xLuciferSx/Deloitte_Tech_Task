//
//  BasketViewControllerRepresentable.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import SwiftUI

struct BasketViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BasketViewController {
        let storyboard = UIStoryboard(name: "Basket", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "BasketViewController") as? BasketViewController else {
            fatalError("BasketViewController not found in Basket storyboard")
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: BasketViewController, context: Context) {}
}

