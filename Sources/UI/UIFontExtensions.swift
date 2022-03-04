//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 04/03/22.
//

import UIKit

public extension UIFont {

    enum MontSerratType: String {
        case black = "Black"
        case blackItalic = "BlackItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case extraBold = "ExtraBold"
        case extraLight = "ExtraLight"
        case extraLightItalic = "ExtraLightItalic"
        case italic = "Italic"
        case light = "Light"
        case lightItalic = "Light-Italic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case regular = "Regular"
        case semiBold = "SemiBold"
        case semiBoldItalic = "SemiBoldItalic"
        case thin = "Thin"
        case thinItalic = "ThinItalic"
    }

    static func custom(_ type: MontSerratType = .regular, ofSize size: CGFloat = UIFont.systemFontSize) -> UIFont {
        guard let customFontName = Theme.theme.customFontName else { return UIFont.systemFont(ofSize: size) }
        return UIFont(name: "\(customFontName)-\(type.rawValue)", size: size)!
    }
}

