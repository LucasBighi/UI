//
//  aaa.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 10/02/22.
//

import UIKit
import Stevia

public protocol AppTheme {
    // MARK: Fonts
    var headerFont: UIFont { get }
    var titleFont: UIFont { get }
    var subtitleFont: UIFont { get }
    // MARK: Text Field
    var validatorColor: UIColor? { get }
    // MARK: Button
    var buttonCornerRadius: CGFloat { get }
    func buttonHeight(ofStyle style: Button.Style, where isEnabled: Bool) -> CGFloat
    func buttonBackgroundColor(ofStyle style: Button.Style, where isEnabled: Bool) -> UIColor?
    func buttonBorderColor(ofStyle style: Button.Style, where isEnabled: Bool) -> UIColor?
    func buttonTitleColor(ofStyle style: Button.Style, where isEnabled: Bool) -> UIColor?
    func buttonFont(ofStyle style: Button.Style, where isEnabled: Bool) -> UIFont
    // MARK: Primary Button
    // MARK: Check Button
    func checkButtonBackgroundColor(where isChecked: Bool) -> UIColor?
    func checkButtonBorderColor(where isChecked: Bool) -> UIColor?
    // MARK: ViewController
    var viewControllerBackgroundColor: UIColor? { get }
}





public struct UI {
    private static var settedTheme: AppTheme?
    
    static var theme: AppTheme {
        guard let settedTheme = settedTheme else { fatalError("Theme not configured") }
        return settedTheme
    }
    
    public static func configure() {
        if let appDelegate = UIApplication.shared.delegate as? AppTheme {
            self.settedTheme = appDelegate
            setupNavigationBar()
        }
    }
}
extension UI {
    private static func setupNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true

        UIBarButtonItem.appearance().tintColor = .primaryColor
    }
}
