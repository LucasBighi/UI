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

    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = Theme.theme?.primaryButtonHeight(where: isEnabled) ?? 0
        return size
    }

    public init(style: Style, title: String, isEnabled: Bool = true, action: (() -> Void)?) {
        super.init(frame: .zero)
        commonInit(style: style, title: title, isEnabled: isEnabled, action: action)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(style: .primary, title: title(for: .normal) ?? "Button", action: nil)
    }

    func commonInit(style: Style, title: String, isEnabled: Bool = true, action: (() -> Void)?) {
        self._action = action
        addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        setTitle(title, for: .normal)
        layer.borderWidth = 5
        layer.cornerRadius = Theme.theme?.buttonCornerRadius ?? 0
        self.isEnabled = isEnabled
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
