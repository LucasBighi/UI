//
//  EmailTextField.swift
//  UI
//
//  Created by Lucas Marques Bighi on 17/02/22.
//

import UIKit

public class EmailTextField: TextField {

    public init(text: String? = nil, placeholder: String? = nil) {
        super.init(text: text, placeholder: placeholder)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        keyboardType = .emailAddress
        autocorrectionType = .no
        autocapitalizationType = .none
        if #available(iOS 10.0, *) {
            textContentType = .emailAddress
        }
    }
}
