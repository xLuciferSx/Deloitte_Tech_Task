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
        let viewController: BasketViewController = UIStoryboard.instantiateViewController(from: .basket, identifier: .basketViewController)
        return viewController
    }

    func updateUIViewController(_ uiViewController: BasketViewController, context: Context) {}
}

