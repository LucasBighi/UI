//
//  EmailTextField.swift
//  UI
//
//  Created by Lucas Marques Bighi on 17/02/22.
//

import UIKit
import Stevia

public protocol TokenTextFieldDelegate: NSObjectProtocol {
    func editingChanged(_ tokenTextField: TokenTextField)
}

public class TokenTextField: UIView {
    
    private lazy var validatorLabel = { Label(text: nil,
                                              font: .secondary(.regular, ofSize: 12),
                                              textColor: UIColor(hex: "B00020")) }()
    
    private lazy var checkImageView = { return UIImageView(image: UIImage(inModuleNamed: "round-check")) }()
    
    public weak var tokenTextFieldDelegate: TokenTextFieldDelegate?

    private var numberOfFields = 4

    private var tokenFields: [TokenField]?

    public var text: String? {
        get {
            guard let tokenFields = tokenFields else { return nil }
            return tokenFields.compactMap { return $0.text }.joined()
        }
        set {
            let array = newValue?.map { String($0) }
            tokenFields?.forEach { $0.text = array?[$0.tag] }
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 70
        return size
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() { return true }
        tokenFields?.first?.becomeFirstResponder()
        return false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(numberOfFields: 4, fieldsSpacing: 30)
    }
    
    public init(text: String? = nil, numberOfFields: Int, fieldsSpacing: CGFloat = 25) {
        super.init(frame: .zero)
        commonInit(text: text, numberOfFields: numberOfFields, fieldsSpacing: fieldsSpacing)
    }
    
    public func showValidator(withMessage message: String) {
        validatorLabel.text = message
        validatorLabel.isHidden = false
    }
    
    public func getText() -> String {
        return (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func commonInit(text: String? = nil, numberOfFields: Int, fieldsSpacing: CGFloat) {
        self.text = text
        self.numberOfFields = numberOfFields
        setup(fieldsSpacing: fieldsSpacing)
    }

    private func setup(fieldsSpacing: CGFloat) {
        validatorLabel.isHidden = true
        checkImageView.isHidden = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = fieldsSpacing

        tokenFields = (0..<numberOfFields).map {
            let tokenField = TokenField(tag: $0)
            tokenField.font = .systemFont(ofSize: 25, weight: .regular)
            tokenField.textColor = UIColor(hex: "17258E")
            tokenField.Height == Height
            stackView.addArrangedSubview(tokenField)
            return tokenField
        }

        sv(
            validatorLabel,
            stackView,
            checkImageView
        )
        
        layout(
            0,
            |-0-validatorLabel-0-|,
            16,
            |-30-stackView-20-checkImageView.size(20)-0-|,
            0
        )
    }

    private func focusOnTextField(atIndex index: Int) {
        tokenFields?[index].becomeFirstResponder()
    }
    
    @objc
    private func editingDidBegin() {
        tokenFields?.first?.becomeFirstResponder()
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
        tokenField.bottomLine.backgroundColor = .primaryColor
        if let tokenFieldText = tokenField.text, !tokenFieldText.isEmpty {
            if let text = text {
                focusOnTextField(atIndex: text.count == numberOfFields ? text.count - 1 : text.count)
            }
        }
    }

    func editingChanged(_ tokenField: TokenField) {
        tokenTextFieldDelegate?.editingChanged(self)
        if let text = tokenField.text, text.count > 0 {
            if tokenField.tag + 1 < numberOfFields {
                focusOnTextField(atIndex: tokenField.tag + 1)
            } else {
                tokenFields?.last?.resignFirstResponder()
                checkImageView.isHidden = false
            }
        }
    }
}
