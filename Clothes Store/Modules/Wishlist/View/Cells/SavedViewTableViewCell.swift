//
//  SavedViewTableViewCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit
import Kingfisher

class SavedViewTableViewCell: UITableViewCell{

    //Views
    @IBOutlet var cellView: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var addToButton: UIButton!
    @IBOutlet var productImage: UIImageView!
    
    //Variables
    weak var delegate : BuyCellButtonTapped?

    func configureWithProduct(product: Product){
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
        
        self.productName.text = product.name
        self.productPrice.text = CurrencyHelper.getMoneyString(product.price ?? 0)
        self.cellView.dropShadow(radius: 10, opacity: 0.1, color: .black)

    }

    @IBAction func addToBasket(_ sender: Any) {
        delegate?.addProductToBasket(self)
    }
}
