//
//  Button.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 11/02/22.
//

import UIKit

public class CheckButton: IconButton {
    
    var changeValueAction: ((_ isChecked: Bool) -> Void)?

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 20, height: 20)
    }

    public var isChecked: Bool {
        didSet {
            setBorder(color: UI.theme.checkButtonBorderColor(where: isChecked), width: 3, cornerRadius: 5)
            setIcon(isChecked ? UIImage(inModuleNamed: "check-box") : nil)
            tintColor = UI.theme.checkButtonBackgroundColor(where: isChecked)
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
        super.init(icon: isChecked ? UIImage(inModuleNamed: "check-box") : nil, action: nil)
        addTarget(self, action: #selector(didTouch), for: .touchUpInside)
        backgroundColor = .white
        clipsToBounds = true
        setBorder(color: UI.theme.checkButtonBorderColor(where: isChecked), width: 3, cornerRadius: 5)
        tintColor = UI.theme.checkButtonBackgroundColor(where: isChecked)
    }

    @objc
    private func didTouch() {
        self.isChecked = !self.isChecked
    }
}
