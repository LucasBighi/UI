//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 18/03/22.
//

import UIKit

public extension UIView {
    
    func setBorder(color: UIColor?, width: CGFloat, cornerRadius: CGFloat = 0) {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
