//
//  aaa.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 10/02/22.
//

import UIKit
import Stevia

public extension UIFont {
    static func custom(ofSize size: CGFloat, weight: Weight) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}

public protocol ThemeProtocol {
    // MARK: View Colors
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    // MARK: Text Colors
    var primaryTextColor: UIColor { get }
    var secondaryTextColor: UIColor { get }

    // MARK: Fonts
    var headerFont: UIFont { get }
    var titleFont: UIFont { get }
    var subtitleFont: UIFont { get }

    // MARK: Common Button
    var buttonCornerRadius: CGFloat { get }
    // MARK: Primary Button
    func primaryButtonHeight(where isEnabled: Bool) -> CGFloat
    func primaryButtonBackgroundColor(where isEnabled: Bool) -> UIColor
    func primaryButtonBorderColor(where isEnabled: Bool) -> UIColor
    func primaryButtonTitleColor(where isEnabled: Bool) -> UIColor
    func primaryButtonFont(where isEnabled: Bool) -> UIFont
    // MARK: Primary Button
    func secondaryButtonHeight(where isEnabled: Bool) -> CGFloat
    func secondaryButtonBackgroundColor(where isEnabled: Bool) -> UIColor
    func secondaryButtonBorderColor(where isEnabled: Bool) -> UIColor
    func secondaryButtonTitleColor(where isEnabled: Bool) -> UIColor
    func secondaryButtonFont(where isEnabled: Bool) -> UIFont
    // MARK: Check Button
    func checkButtonBackgroundColor(where isChecked: Bool) -> UIColor
    func checkButtonBorderColor(where isChecked: Bool) -> UIColor
    
    // MARK: ViewController
    var viewControllerBackgroundColor: UIColor { get }
}

public class Theme {
    static var theme: ThemeProtocol?

    public static func setTheme(_ theme: ThemeProtocol) {
        self.theme = theme
        setupNavigationBar()
    }
}

extension Theme {
    private static func setupNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true

        UIBarButtonItem.appearance().tintColor = theme?.primaryColor
    }
}
