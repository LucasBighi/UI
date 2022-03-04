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
            showPasswordButton?.backgroundColor = isSecureTextEntry ? .blue : .red
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
        showPasswordButton?.backgroundColor = .blue
        showPasswordButton?.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        rightView = showPasswordButton
        rightViewMode = .always
    }

    @objc
    private func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
    }
}
