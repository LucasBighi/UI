//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 11/03/22.
//

import UIKit

public extension UIImage {
    
    convenience init?(inModuleNamed name: String) {
        self.init(named: name, in: .module, compatibleWith: nil)
    }
}
