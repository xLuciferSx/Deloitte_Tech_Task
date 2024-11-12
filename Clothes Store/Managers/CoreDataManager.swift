//
//  CoreDataManager.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ClothesStoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager {
    func createOrFetchProductEntity(for product: Product) -> ProductEntity {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productId == %@", product.productId)

        if let existingProduct = (try? context.fetch(fetchRequest))?.first {
            return existingProduct
        } else {
            let newProduct = ProductEntity(context: context)
            newProduct.productId = product.productId
            newProduct.name = product.name
            newProduct.category = product.category?.rawValue
            newProduct.price = product.price ?? 0
            newProduct.stock = Int16(product.stock ?? 0)
            newProduct.oldPrice = product.oldPrice ?? 0
            newProduct.image = product.image
            newProduct.isWishlisted = product.isWishlisted ?? false
            return newProduct
        }
    }

    func convertToProduct(_ productEntity: ProductEntity) -> Product {
        return Product(
            productId: productEntity.productId ?? "",
            name: productEntity.name ?? "",
            category: Category(rawValue: productEntity.category ?? ""),
            price: productEntity.price,
            stock: Int(productEntity.stock),
            oldPrice: productEntity.oldPrice,
            image: productEntity.image,
            isWishlisted: productEntity.isWishlisted
            
        )
    }
    
    func saveProductToWishlist(_ product: Product) {
        let productEntity = createOrFetchProductEntity(for: product)
        let wishlistItem = WishlistEntity(context: context)
        wishlistItem.product = productEntity
        saveContext()
    }

    func removeProductFromWishlist(_ product: Product) {
        let fetchRequest: NSFetchRequest<WishlistEntity> = WishlistEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "product.productId == %@", product.productId)

        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                context.delete(item)
            }
            saveContext()
        } catch {
            print("Failed to delete product from wishlist: \(error)")
        }
    }
    
    func toggleWishlistStatus(for product: Product) {
        let productEntity = createOrFetchProductEntity(for: product)
        productEntity.isWishlisted.toggle()
        saveContext()
    }
    
    func fetchWishlist() -> [Product] {
        let fetchRequest: NSFetchRequest<WishlistEntity> = WishlistEntity.fetchRequest()
        do {
            let wishlistItems = try context.fetch(fetchRequest)
            return wishlistItems.compactMap { $0.product }.map { convertToProduct($0) }
        } catch {
            print("Failed to fetch wishlist: \(error)")
            return []
        }
    }
    
    func saveProductToBasket(_ product: Product, quantity: Int) {
        let productEntity = createOrFetchProductEntity(for: product)
        let basketItem = BasketEntity(context: context)
        basketItem.product = productEntity
        basketItem.quantity = Int16(quantity)
        saveContext()
    }

    func removeProductFromBasket(_ product: Product) {
        let fetchRequest: NSFetchRequest<BasketEntity> = BasketEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "product.productId == %@", product.productId)

        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                context.delete(item)
            }
            saveContext()
        } catch {
            print("Failed to delete product from basket: \(error)")
        }
    }

    func fetchBasket() -> [(product: Product, quantity: Int)] {
        let fetchRequest: NSFetchRequest<BasketEntity> = BasketEntity.fetchRequest()
        do {
            let basketItems = try context.fetch(fetchRequest)
            return basketItems.compactMap { item in
                guard let productEntity = item.product else {
                    return nil
                }
                let product = convertToProduct(productEntity)
                let quantity = Int(item.quantity)
                return (product, quantity)
            }
        } catch {
            print("Failed to fetch basket: \(error)")
            return []
        }
    }
}
