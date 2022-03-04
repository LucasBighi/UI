//
//  aaa.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 10/02/22.
//

import UIKit
import Stevia

public protocol ThemeProtocol {
    // MARK: View Colors
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var terciaryColor: UIColor { get }
    // MARK: Text Colors
    var primaryTextColor: UIColor { get }
    var secondaryTextColor: UIColor { get }
    
    // MARK: Fonts
    var customFontName: String? { get }
    var headerFont: UIFont { get }
    var titleFont: UIFont { get }
    var subtitleFont: UIFont { get }

    // MARK: Common Button
    var buttonCornerRadius: CGFloat { get }
    // MARK: Button
    func buttonHeight(ofStyle style: Button.Style, where isEnabled: Bool) -> CGFloat
    func buttonBackgroundColor(ofStyle style: Button.Style, where isEnabled: Bool) -> UIColor
    func buttonBorderColor(ofStyle style: Button.Style, where isEnabled: Bool) -> UIColor
    func buttonTitleColor(ofStyle style: Button.Style, where isEnabled: Bool) -> UIColor
    func buttonFont(ofStyle style: Button.Style, where isEnabled: Bool) -> UIFont
    // MARK: Primary Button
    // MARK: Check Button
    func checkButtonBackgroundColor(where isChecked: Bool) -> UIColor
    func checkButtonBorderColor(where isChecked: Bool) -> UIColor
    
    // MARK: ViewController
    var viewControllerBackgroundColor: UIColor { get }
}

public class Theme {
    private static var settedTheme: ThemeProtocol?
    
    static var theme: ThemeProtocol {
        guard let settedTheme = settedTheme else { fatalError("Theme not configured") }
        return settedTheme
    }

    public static func setTheme(_ theme: ThemeProtocol) {
        self.settedTheme = theme
        setupNavigationBar()
    }
}

extension Theme {
    private static func setupNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true

        UIBarButtonItem.appearance().tintColor = theme.primaryColor
    }
}
