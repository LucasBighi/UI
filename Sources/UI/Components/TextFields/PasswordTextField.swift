//
//  EmailTextField.swift
//  UI
//
//  Created by Lucas Marques Bighi on 17/02/22.
//

import UIKit

public class PasswordTextField: TextField {

    private var showPasswordButton: UIButton?

    public override var isSecureTextEntry: Bool {
        didSet {
            showPasswordButton?.setImage(isSecureTextEntry
                                         ? UIImage(named: "visibility-on", in: .module, compatibleWith: nil)
                                         : UIImage(named: "visibility-off", in: .module, compatibleWith: nil),
                                         for: .normal)
        }
    }

    public init(text: String? = nil, placeholder: String? = nil) {
        super.init(text: text, placeholder: placeholder)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        isSecureTextEntry = true
    }

    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return CGRect(x: rect.minX, y: -5, width: rect.width, height: rect.height)
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        showPasswordButton = UIButton(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: intrinsicContentSize.height,
                                                    height: intrinsicContentSize.height))
        showPasswordButton?.setImage(UIImage(inModuleNamed: "visibility-on"), for: .normal)
        showPasswordButton?.tintColor = .black.withAlphaComponent(0.6)
        showPasswordButton?.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        rightView = showPasswordButton
        rightViewMode = .always
    }

    @objc
    private func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
    }
}
