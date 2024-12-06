//
//  CatalogueViewCollectionCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class CatalogueViewCollectionViewCell: UICollectionViewCell {
  @IBOutlet var productName: UILabel!
  @IBOutlet var productPrice: UILabel!
  @IBOutlet var cellView: UIView!
  @IBOutlet var wishListed: UIImageView!
  @IBOutlet var productImage: UIImageView!
    
  func configureWithProduct(product: Product) {
    self.productName.text = product.name
    self.productPrice.text = CurrencyHelper.getMoneyString(product.price ?? 0)
    self.cellView.dropShadow(radius: 10, opacity: 0.1, color: .black)
    let placeHolderImage = UIImage(named: "placeholderImage")
        
    if let imageUrl = URL(string: product.image ?? "") {
      URLSession.shared.dataTask(with: imageUrl) { data, _, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async {
          self.productImage.image = UIImage(data: data)
        }
      }.resume()
    } else {
      self.productImage.image = placeHolderImage
    }
  }
    
  override func prepareForReuse() {
    super.prepareForReuse()
    super.prepareForReuse()
    self.productName.text = nil
    self.productPrice.text = nil
    self.productImage.image = UIImage(named: "placeholderImage")
  }
}
