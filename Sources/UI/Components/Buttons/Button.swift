//
//  Button.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 11/02/22.
//

import UIKit

fileprivate var actionKey: Void?

public class Button: UIButton {

    private var _action: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &actionKey) as? () -> Void
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var style: Style

    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = Theme.theme.buttonHeight(ofStyle: style, where: isEnabled)
        return size
    }

    public init(style: Style, title: String, isEnabled: Bool = true, action: (() -> Void)?) {
        self.style = style
        super.init(frame: .zero)
        commonInit(title: title, isEnabled: isEnabled, action: action)
    }

    public required init?(coder: NSCoder) {
        self.style = .primary
        super.init(coder: coder)
        commonInit(title: title(for: .normal) ?? "Button", action: nil)
    }

    func commonInit(title: String, isEnabled: Bool = true, action: (() -> Void)?) {
        self.isEnabled = isEnabled
        self._action = action
        addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        setTitle(title, for: .normal)
        titleLabel?.font = Theme.theme.buttonFont(ofStyle: style, where: isEnabled)
        backgroundColor = Theme.theme.buttonBackgroundColor(ofStyle: style, where: isEnabled)
        layer.borderWidth = 5
        layer.borderColor = Theme.theme.buttonBorderColor(ofStyle: style, where: isEnabled).cgColor
        layer.cornerRadius = Theme.theme.buttonCornerRadius
    }

    @objc private func pressed(sender: UIButton) {
        _action?()
    }
}

extension Button {
    public enum Style {
        case primary, secondary
    }
}
