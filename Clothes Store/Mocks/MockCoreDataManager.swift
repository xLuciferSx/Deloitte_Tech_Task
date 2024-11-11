//
//  MockCoreDataManager.swift
//  Clothes Store
//
//  Created by Raivis on 11/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import CoreData

class MockCoreDataManager: CoreDataManager {

    override init() {
        super.init()
        self.persistentContainer = {
            let container = NSPersistentContainer(name: "ClothesStoreData")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            
            container.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Unresolved error \(error)")
                }
            }
            return container
        }()
    }
}

