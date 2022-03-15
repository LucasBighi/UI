//
//  EmailTextField.swift
//  UI
//
//  Created by Lucas Marques Bighi on 17/02/22.
//

import UIKit
import Stevia

@objc protocol TokenFieldDelegate: NSObjectProtocol {
    func editingChanged(_ tokenField: TokenField)
    func didBeginEditing(_ tokenField: TokenField)
    func didDeleteBackward(_ tokenField: TokenField)
}

class TokenField: TextField {

    weak var tokenFieldDelegate: TokenFieldDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(tag: 0)
    }

    override func deleteBackward() {
        super.deleteBackward()
        tokenFieldDelegate?.didDeleteBackward(self)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return CGRect(x: rect.minX, y: 0, width: rect.width, height: rect.height + 20)
    }

    init(tag: Int) {
        super.init()
        commonInit(tag: tag)
    }

    private func commonInit(tag: Int) {
        self.tag = tag
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
        self.keyboardType = .numberPad
        self.textAlignment = .center
        self.addTarget(tokenFieldDelegate, action: #selector(tokenFieldDelegate?.didBeginEditing(_:)), for: .editingDidBegin)
        self.addTarget(tokenFieldDelegate, action: #selector(tokenFieldDelegate?.editingChanged(_:)), for: .editingChanged)
    }
}

public class TokenTextField: TextField {

    private var numberOfFields = 4

    private var tokenFields: [TokenField]?

    public override var text: String? {
        get {
            guard let tokenFields = tokenFields else { return nil }
            return tokenFields.compactMap { return $0.text }.joined()
        }
        set {
            print(newValue)
        }
    }

    public init(text: String? = nil, numberOfFields: Int, fieldsSpacing: CGFloat = 10) {
        super.init(text: text, placeholder: nil, mask: nil)
        commonInit(numberOfFields: numberOfFields, fieldsSpacing: fieldsSpacing)
    }

    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 50
        return size
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(numberOfFields: 4)
    }

    private func commonInit(numberOfFields: Int, fieldsSpacing: CGFloat = 10) {
        backgroundColor = .clear
        bottomLine.isHidden = true
        self.numberOfFields = numberOfFields
        setupTextFields(fieldsSpacing: fieldsSpacing)
    }

    private func setupTextFields(fieldsSpacing: CGFloat) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = fieldsSpacing

        tokenFields = (0..<numberOfFields).map {
            let tokenField = TokenField(tag: $0)
            tokenField.Height == Height
            tokenField.tokenFieldDelegate = self
            stackView.addArrangedSubview(tokenField)
            return tokenField
        }

        sv(stackView)
        stackView.fillContainer()
    }

    private func focusOnTextField(atIndex index: Int) {
        tokenFields?[index].becomeFirstResponder()
    }
}

extension TokenTextField: TokenFieldDelegate {
    func didDeleteBackward(_ tokenField: TokenField) {
        if tokenField.tag != 0 {
            guard let previousTokenField = tokenFields?[tokenField.tag - 1] else { return }
            previousTokenField.text = nil
            focusOnTextField(atIndex: previousTokenField.tag)
        }
    }

    func didBeginEditing(_ tokenField: TokenField) {
        if let tokenFieldText = tokenField.text, !tokenFieldText.isEmpty {
            if let text = text {
                focusOnTextField(atIndex: text.count == numberOfFields ? text.count - 1 : text.count)
            }
        }
    }

    func editingChanged(_ tokenField: TokenField) {
        if let text = tokenField.text, text.count > 0 {
            if tokenField.tag + 1 < numberOfFields {
                focusOnTextField(atIndex: tokenField.tag + 1)
            } else {
                tokenFields?.last?.resignFirstResponder()
            }
        }
    }
}
