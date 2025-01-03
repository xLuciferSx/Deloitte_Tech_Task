//
//  CatalogueViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Factory
import UIKit

class CatalogueViewController: UIViewController {
  @Injected(\.dataService) var dataService
  
  // Views
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var activity: UIActivityIndicatorView!

  // Variables
  var products: [Product] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    getProducts()
  }

  func getProducts() {
    dataService.getProducts { [weak self] result in
      switch result {
      case .success(let productsData):
        self?.products = productsData.products ?? []
        self?.activity.isHidden = true
        self?.collectionView.reloadData()
      case .failure:
        let alert = UIAlertController(
          title: "Error",
          message: "There has been an error getting the data. Please check your network connection and try again.",
          preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
          self?.getProducts()
        }))
        self?.present(alert, animated: true, completion: nil)
      }
    }
  }
}

extension CatalogueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return products.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CatalogueViewCollectionViewCell

    let product = products[indexPath.row]
    cell.configureWithProduct(product: product)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    return CGSize(width: itemSize, height: 250)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let product = products[indexPath.row]

    let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailContainer") as! DetailViewContainerViewController
    let navigationVC = UINavigationController(rootViewController: detailVC)
    detailVC.product = product
    Haptic.feedBack()
    present(navigationVC, animated: true, completion: nil)
  }
}
