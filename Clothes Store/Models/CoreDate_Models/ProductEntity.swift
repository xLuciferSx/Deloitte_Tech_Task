//
//  ProductEntity.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//


import CoreData
    
@objc(ProductEntity)
public class ProductEntity: NSManagedObject {
    @NSManaged public var productId: String
    @NSManaged public var name: String
    @NSManaged public var category: String?
    @NSManaged public var price: Float
    @NSManaged public var stock: Int
    @NSManaged public var oldPrice: Float
    @NSManaged public var image: String?
}

@objc(WishlistItem)
public class WishlistItem: NSManagedObject {
    @NSManaged public var product: ProductEntity
}

@objc(BasketItem)
public class BasketItem: NSManagedObject {
    @NSManaged public var product: ProductEntity
    @NSManaged public var quantity: Int
}
