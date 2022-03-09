//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 07/03/22.
//

import UIKit
import Utils

public extension UIColor {
    static let primaryColor = UIColor(hex: AppInfo.infoForKey(.primaryColorHEX))
    static let secondaryColor = UIColor(hex: AppInfo.infoForKey(.secondaryColorHEX))
    static let terciaryColor = UIColor(hex: AppInfo.infoForKey(.terciaryColorHEX))
    static let primaryTextColor = UIColor(hex: AppInfo.infoForKey(.primaryTextColorHEX))
    static let secondaryTextColor = UIColor(hex: AppInfo.infoForKey(.secondaryTextColorHEX))
    
    convenience init?(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return nil
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1)
    }
}
