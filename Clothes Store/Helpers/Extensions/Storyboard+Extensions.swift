//
//  Storyboard+Extensions.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case productDetail = "ProductDetail"
    case wishlist = "Wishlist"
    case basket = "Basket"
}

enum ViewControllerIdentifier: String {
    case detailViewContainer = "DetailViewContainerViewController"
    case wishlistViewController = "WishlistViewController"
    case basketViewController = "BasketViewController"
}

extension UIStoryboard {
    static func instantiateViewController<T: UIViewController>(from storyboard: StoryboardName, identifier: ViewControllerIdentifier) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as? T else {
            fatalError("Could not instantiate view controller with identifier \(identifier.rawValue) from storyboard \(storyboard)")
        }
        return viewController
    }
}

