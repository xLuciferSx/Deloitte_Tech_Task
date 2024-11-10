//
//  BasketViewTableViewCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Kingfisher
import UIKit

class BasketViewTableViewCell: UITableViewCell {
    // Views
    @IBOutlet var cellView: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var quantity: UILabel!

    // Variables
    weak var delegate: BuyCellButtonTapped?
    private var product: Product?

    func configureWithProduct(product: Product, quantity: Int) {
        self.product = product

        if let imageUrlString = product.image, let imageUrl = URL(string: imageUrlString) {
            productImage.kf.setImage(
                with: imageUrl,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        } else {
            productImage.image = UIImage(named: "placeholderImage")
        }

        productName.text = product.name
        productPrice.text = CurrencyHelper.getMoneyString(product.price ?? 0)
        self.quantity.text = "Qty: \(quantity)"

        cellView.dropShadow(radius: 10, opacity: 0.1, color: .black)
    }
}
