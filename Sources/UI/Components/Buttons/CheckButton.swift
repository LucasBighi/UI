//
//  Button.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 11/02/22.
//

import UIKit

public class CheckButton: Button {
    
    var changeValueAction: ((_ isChecked: Bool) -> Void)?

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 20, height: 20)
    }

    public var isChecked: Bool {
        didSet {
            layer.borderColor = UI.theme.checkButtonBorderColor(where: isChecked)?.cgColor
            setBackgroundImage(isChecked ? UIImage(inModuleNamed: "checkbox") : nil, for: .normal)
            changeValueAction?(isChecked)
        }
    }

    public required init?(coder: NSCoder) {
        self.isChecked = true
        super.init(coder: coder)
        commonInit(title: "", isEnabled: true, action: nil)
    }

    public init(isChecked: Bool = false, changeValueAction: ((_ isChecked: Bool) -> Void)?) {
        self.isChecked = isChecked
        self.changeValueAction = changeValueAction
        super.init(style: .primary, title: "", isEnabled: true, action: nil)
        addTarget(self, action: #selector(didTouch), for: .touchUpInside)
        backgroundColor = .white
        layer.borderWidth = 2
        layer.cornerRadius = 2
        layer.borderColor = UI.theme.checkButtonBorderColor(where: isChecked)?.cgColor
        setBackgroundImage(isChecked ? UIImage(inModuleNamed: "checkbox") : nil, for: .normal)
    }

    @objc
    private func didTouch() {
        self.isChecked = !self.isChecked
    }
}
