//
//  EmailTextField.swift
//  UI
//
//  Created by Lucas Marques Bighi on 17/02/22.
//

import UIKit

public class NumericTextField: TextField {

    public override init(text: String? = nil, placeholder: String? = nil, mask: Mask? = nil) {
        super.init(text: text, placeholder: placeholder, mask: mask)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        keyboardType = .numberPad
        if #available(iOS 10.0, *), let mask = stringMask, mask == .phone {
            textContentType = .telephoneNumber
        }
    }
}
