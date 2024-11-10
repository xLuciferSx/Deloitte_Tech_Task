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
        let viewController: DetailViewContainerViewController = UIStoryboard.instantiateViewController(from: .productDetail, identifier: .detailViewContainer)
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
