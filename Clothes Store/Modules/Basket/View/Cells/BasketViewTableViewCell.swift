//
//  BasketViewTableViewCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Kingfisher
import UIKit

protocol BasketCellDelegate: AnyObject {
    func didTapPlus(for product: Product)
    func didTapMinus(for product: Product)
}

class BasketViewTableViewCell: UITableViewCell {
    // Views
    @IBOutlet var cellView: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!

    // Variables
    weak var delegate: BasketCellDelegate?
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

    @IBAction func plusTapped(_ sender: Any) {
        guard let product = product else { return }
        delegate?.didTapPlus(for: product)
    }

    @IBAction func minusTapped(_ sender: Any) {
        guard let product = product else { return }
        delegate?.didTapMinus(for: product)
    }
}
