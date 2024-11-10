//
//  DetailViewController_Presenter.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import SwiftUI

struct DetailViewControllerRepresentable: UIViewControllerRepresentable {
    var product: Product
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> DetailViewContainerViewController {
        let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewContainerViewController") as! DetailViewContainerViewController
        viewController.product = product
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: DetailViewContainerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, DetailViewContainerDelegate {
        var parent: DetailViewControllerRepresentable

        init(_ parent: DetailViewControllerRepresentable) {
            self.parent = parent
        }

        func didCloseDetailView() {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
