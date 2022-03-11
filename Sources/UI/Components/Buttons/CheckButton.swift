//
//  Button.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 11/02/22.
//

import UIKit

public class CheckButton: Button {

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 40)
    }

    public var isChecked: Bool {
        didSet {
            backgroundColor = UI.theme.checkButtonBackgroundColor(where: isChecked)
            layer.borderColor = UI.theme.checkButtonBorderColor(where: isChecked)?.cgColor
            setBackgroundImage(isChecked ? UIImage(named: "checkbox", in: .module, compatibleWith: nil) : nil,
                               for: .normal)
        }
    }

    public required init?(coder: NSCoder) {
        self.isChecked = true
        super.init(coder: coder)
        commonInit(title: "", isEnabled: true, action: nil)
    }

    public init(isChecked: Bool = false) {
        self.isChecked = isChecked
        super.init(style: .primary, title: "", isEnabled: true, action: nil)
        addTarget(self, action: #selector(didTouch), for: .touchUpInside)
        layer.borderWidth = 5
        layer.cornerRadius = UI.theme.buttonCornerRadius
        backgroundColor = UI.theme.checkButtonBackgroundColor(where: isChecked)
        layer.borderColor = UI.theme.checkButtonBorderColor(where: isChecked)?.cgColor
        setBackgroundImage(isChecked ? UIImage(named: "checkbox", in: .module, compatibleWith: nil) : nil,
                           for: .normal)
    }

    @objc
    private func didTouch() {
        self.isChecked = !self.isChecked
    }
}
