//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 04/03/22.
//

import UIKit

extension UIFont {

    public enum MontSerratType: String {
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

    static func montSerrat(_ type: MontSerratType = .regular, ofSize size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Montserrat-\(type.rawValue)", size: size)!
    }
}

