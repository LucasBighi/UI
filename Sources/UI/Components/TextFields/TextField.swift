//
//  TextField.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 11/02/22.
//

import UIKit
import Stevia

public protocol TextFieldDelegate: NSObjectProtocol {
    func textFieldDidBeginEditing(_ textField: TextField)
    func textFieldEditingChanged(_ textField: TextField)
    func textFieldDidEndEditing(_ textField: TextField)
    func textFieldShouldReturn(_ textField: TextField) -> Bool
}

public protocol TextFieldValidatorDelegate: NSObjectProtocol {
    func validator(inTextField textField: TextField) -> Bool
    func viewForValidator(inTextField textField: TextField) -> UIView
}

public extension TextFieldValidatorDelegate {
    func validator(inTextField textField: TextField) -> Bool {
        return textField.text != nil && !textField.text!.isEmpty
    }

    func viewForValidator(inTextField textField: TextField) -> UIView {
        return UIView()
    }
}

public class TextField: UITextField {

    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    lazy var floatPlaceholder: UILabel = {
        let label = UILabel()
        label.attributedText = self.attributedPlaceholder
        label.text = self.placeholder
        return label
    }()

    private var previousValue: String?
//    private var validatorView: UIView!

    public weak var textFieldDelegate: TextFieldDelegate?
    public weak var validatorDelegate: TextFieldValidatorDelegate?

    var stringMask: Mask?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override var text: String? {
        didSet {
            textFieldDelegate?.textFieldEditingChanged(self)
        }
    }

    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 50
        return size
    }

    public override func draw(_ rect: CGRect) {
//        setupValidatorView()
////        setupFloatPlaceholder()
//        sv(
//            bottomLine,
//            validatorView
//        )
//
//        layout(
//            textRect(forBounds: bounds).maxY,
//            |-0-bottomLine-0-| ~ 1,
//            10,
//            |-0-validatorView-0-| ~ 20
//        )
        if let validatorView = validatorDelegate?.viewForValidator(inTextField: self) {
            sv(
                bottomLine,
                validatorView
            )
    
            layout(
                textRect(forBounds: bounds).maxY,
                |-0-bottomLine-0-| ~ 1,
                10,
                |-0-validatorView-0-| ~ 20
            )
        }
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return CGRect(x: rect.minX, y: 0, width: rect.width, height: rect.height - 20)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    public init(text: String? = nil, placeholder: String? = nil, mask: Mask? = nil) {
        super.init(frame: .zero)
        commonInit(text: text, placeholder: placeholder, mask: mask)
    }

    private func setupFloatPlaceholder() {
        let phBounds = placeholderRect(forBounds: bounds)
//        floatPlaceholder.text = "Float placeholder"
        sv(floatPlaceholder)
        layout(
            phBounds.minY,
            |-phBounds.minX-floatPlaceholder-| ~ phBounds.height
        )
        placeholder = nil
    }

    private func commonInit(text: String? = nil, placeholder: String? = nil, mask: Mask? = nil) {
        delegate = self
        self.text = text
        self.placeholder = placeholder
        self.stringMask = mask

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange,
                                               object: self,
                                               queue: nil) { [weak self] notification in
            guard let strongSelf = self else { return }
            guard let object = notification.object as? TextField, object == strongSelf else { return }

            if strongSelf.previousValue != strongSelf.text {
                strongSelf.textFieldDelegate?.textFieldEditingChanged(strongSelf)
            }
            strongSelf.previousValue = strongSelf.text
        }
    }

    @objc
    private func editingChanged() {
        textFieldDelegate?.textFieldEditingChanged(self)
    }

    @discardableResult
    public func validate() -> Bool {
        let isValid = validatorDelegate?.validator(inTextField: self) ?? false
//        validatorView.isHidden = isValid
        bottomLine.backgroundColor = !isValid ? #colorLiteral(red: 0.6901960784, green: 0, blue: 0.1254901961, alpha: 1) : isEditing ? .primaryColor : .gray
        return isValid
    }

    private func setupValidatorView() {
//        validatorView = validatorDelegate?.viewForValidator(inTextField: self)
//        validatorView.isHidden = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(NSNotification.Name.UITextFieldTextDidChange)
    }
}

extension TextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.floatPlaceholder.topConstraint?.constant = -15
            self.floatPlaceholder.widthConstraint?.constant = 30
            self.layoutIfNeeded()
        }
        textFieldDelegate?.textFieldDidBeginEditing(self)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.floatPlaceholder.topConstraint?.constant = 0
            self.floatPlaceholder.widthConstraint?.constant = self.bounds.width
            self.layoutIfNeeded()
        }
        textFieldDelegate?.textFieldDidEndEditing(self)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        guard let mask = stringMask else { return true }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(withMask: mask, phone: newString)
        return false
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textFieldDelegate?.textFieldShouldReturn(self) ?? true
    }
}

extension TextField {
    public enum Mask: Equatable {
        case cpf
        case phone
        case custom(mask: String)

        var rawValue: String {
            switch self {
            case .cpf:
                return "###.###.###-##"
            case .phone:
                return "(##) #####-####"
            case .custom(let mask):
                return mask
            }
        }
    }

    /// mask example: `+X (XXX) XXX-XXXX`
    private func format(withMask mask: Mask, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask.rawValue where index < numbers.endIndex {
            if ch == "#" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}
