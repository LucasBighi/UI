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
        return UIFont(name: "\(primaryFontName)-\(type.rawValue.capitalized)", size: size)!
    }
    
    static func secondary(_ type: FontType = .regular, ofSize size: CGFloat = UIFont.systemFontSize) -> UIFont {
        let secondaryFontName = AppInfo.infoForKey(.secondaryFontName)
        return UIFont(name: "\(secondaryFontName)-\(type.rawValue.capitalized)", size: size)!
    }
    
    var fontType: FontType {
        guard let range = self.fontName.range(of: "-") else { return .regular }
        let fontTypeString = self.fontName[range.upperBound...]
        switch fontTypeString {
        case "Regular":
            return .regular
        case "Bold":
            return .bold
        case "Light":
            return .light
        default:
            return .regular
        }
    }
    
    var fontFamily: String? {
        guard let range = self.fontName.range(of: "-") else { return nil }
        return String(self.fontName[..<range.lowerBound])
    }
}

