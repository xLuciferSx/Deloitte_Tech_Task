//
//  String+Extensions.swift
//  Clothes Store
//
//  Created by Raivis on 12/11/2024.
//  Copyright © 2024 RichieHope. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        let format = NSLocalizedString(self, comment: "")
        return String(format: format, arguments: arguments)
    }
}
