//
//  Container.swift
//  Clothes Store
//
//  Created by Raivis on 11/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Factory

extension Container {
    static let shared = Container()
    
    static func setup() {
        shared.coreDataManager.register { CoreDataManager.shared }
        shared.storeManager.register { StoreManager.shared }
    }
    
    var coreDataManager: Factory<CoreDataManager> {
        Factory(self) { CoreDataManager.shared }
    }
    
    var storeManager: Factory<StoreManager> {
        Factory(self) { StoreManager.shared }
    }
}
