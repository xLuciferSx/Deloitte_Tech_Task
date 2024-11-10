//
//  Coordinator.swift
//  Clothes Store
//
//  Created by Raivis on 10/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import UIKit
import SwiftUI

class Coordinator {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let catalogueView = MainTabView()
        let hostingController = UIHostingController(rootView: catalogueView)
        
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
}
