//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 04/03/22.
//

import UIKit
import Utils

public extension UIFont {
    enum FontType: String {
        case bold
        case regular
        case light
    }

    static func primary(_ type: FontType = .regular, ofSize size: CGFloat = UIFont.systemFontSize) -> UIFont {
        let primaryFontName = AppInfo.infoForKey(.primaryFontName)
        return UIFont(name: "\(primaryFontName)-\(type.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: 10)
    }
    
    static func secondary(_ type: FontType = .regular, ofSize size: CGFloat = UIFont.systemFontSize) -> UIFont {
        let secondaryFontName = AppInfo.infoForKey(.secondaryFontName)
        return UIFont(name: "\(secondaryFontName)-\(type.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: 10)
    }
}

