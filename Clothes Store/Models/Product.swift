//
//  Product
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Products
struct Products: Codable {
    var products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    var productId: String
    var name: String
    var category: Category?
    var price: Float?
    var stock: Int?
    var oldPrice: Float?
    var image: String?
}

enum Category: String, Codable {
    case pants = "Pants"
    case shoes = "Shoes"
    case tops = "Tops"
}

// MARK: - Cart
struct Cart: Codable {
    let cartId, productId: Int?
}

extension Product: Identifiable {
    var id: String { productId }
}
