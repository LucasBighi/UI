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
            let array = newValue?.map { String($0) }
            tokenFields?.forEach { $0.text = array?[$0.tag] }
        }
    }
    
    public override var textFieldDelegate: TextFieldDelegate? {
        didSet {
            tokenFields?.forEach { $0.textFieldDelegate = textFieldDelegate }
        }
    }
    
    public override var validatorDelegate: TextFieldValidatorDelegate? {
        didSet {
            tokenFields?.forEach { $0.validatorDelegate = validatorDelegate }
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 70
        return size
    }
    
    public override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() { return true }
        tokenFields?.first?.becomeFirstResponder()
        return false
    }
    
    public override func draw(_ rect: CGRect) {
        sv(
            bottomLine,
            validatorContentView
        )

        layout(
            0,
            |-0-validatorContentView-0-|,
            10,
            textRect(forBounds: bounds).maxY,
            |-0-bottomLine-0-| ~ 1
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(numberOfFields: 4, fieldsSpacing: 30)
    }
    
    public init(text: String? = nil, numberOfFields: Int, fieldsSpacing: CGFloat = 25) {
        super.init(text: text, placeholder: nil, mask: nil)
        commonInit(numberOfFields: numberOfFields, fieldsSpacing: fieldsSpacing)
    }
    
    public func showValidator(withMessage message: String) {
        guard let validatorLabel = validatorDelegate?.viewForValidator(in: self) as? Label else { return }
        validatorLabel.text = message
    }

    private func commonInit(numberOfFields: Int, fieldsSpacing: CGFloat) {
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
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
            tokenField.font = .systemFont(ofSize: 25, weight: .regular)
            tokenField.textColor = UIColor(hex: "17258E")
            tokenField.Height == Height
            tokenField.tokenFieldDelegate = self
            tokenField.validatorDelegate = self
            stackView.addArrangedSubview(tokenField)
            return tokenField
        }
        
        let checkImageView = UIImageView(image: UIImage(inModuleNamed: "round-check"))

        sv(stackView, checkImageView)
        layout(
            0,
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

extension TokenTextField: TextFieldValidatorDelegate {
    public func validator(in textField: TextField) -> Bool {
        return false
    }
    
    public func viewForValidator(in textField: TextField) -> UIView {
        let label = Label(text: "Código inválido ou expirado",
                          font: .systemFont(ofSize: 12, weight: .regular),
                          textColor: UIColor(hex: "B00020"))
        return label
    }
}
