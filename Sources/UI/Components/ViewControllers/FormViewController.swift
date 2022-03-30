//
//  FormViewController.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit
import Stevia

open class FormViewController: BaseViewController {

    private var activeTextField: TextField?
    private var textFields: [TextField]?
    private var submitButton: Button?
    private var submitButtonBottomSpace: CGFloat?

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        textFields?.first?.becomeFirstResponder()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }

    private func setupUI() {
        setupTextFields()
        setupSubmitButton()
    }

    private func setupTextFields() {
        textFields = view.subviews.compactMap { $0 as? TextField }

        textFields?.forEach {
            $0.tag = textFields?.firstIndex(of: $0) ?? 0

            $0.textFieldDelegate = self

            if let textFields = textFields {
                $0.returnKeyType = textFields.count - 1 == $0.tag ? .done : .next
            }

            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            toolbar.barStyle = .default

            let previous = UIBarButtonItem(title: "﹤", style: .done, target: self, action: #selector(activePreviousTextField))
            let next = UIBarButtonItem(title: "﹥", style: .done, target: self, action: #selector(activeNextTextField))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(endEditing))

            if self.textFields?.count == 1 {
                toolbar.items = [flexSpace, done]
            } else if $0 == self.textFields?.first {
                toolbar.items = [next, flexSpace, done]
            } else if $0 == self.textFields?.last {
                toolbar.items = [previous, flexSpace, done]
            } else {
                toolbar.items = [previous, next, flexSpace, done]
            }

            toolbar.sizeToFit()

            $0.inputAccessoryView = toolbar
        }
    }

    private func setupSubmitButton() {
        submitButton = view.subviews.compactMap { $0 as? Button }.first
        submitButtonBottomSpace = submitButton?.bottomConstraint?.constant
    }

    @objc private func activeNextTextField() {
        textFields?.first(where: { $0.tag == (activeTextField?.tag ?? 0) + 1 })?.becomeFirstResponder()
    }

    @objc private func activePreviousTextField() {
        textFields?.first(where: { $0.tag == (activeTextField?.tag ?? 0) - 1 })?.becomeFirstResponder()
    }

    @objc open func endEditing() {
        view.subviews.forEach { $0.endEditing(true) }
    }

    public func submit(completion: @escaping (_ invalidTextFields: [TextField]?,
                                              _ validTextFields: [TextField]?) -> Void) {
        let invalidTextFields = textFields?.filter { !$0.validate() }
        let validTextFields = textFields?.filter { $0.validate() }
        
        completion(invalidTextFields, validTextFields)
    }
}

extension FormViewController {
    @objc open func keyboardWillShow(notification: NSNotification) {
        animateWithKeyboard(notification: notification) {
            (keyboardFrame) in
            let constant = -(20 + keyboardFrame.height)
            self.submitButton?.bottomConstraint?.constant = constant
        }
    }

    @objc open func keyboardWillHide(notification: NSNotification) {
        animateWithKeyboard(notification: notification) {
              (keyboardFrame) in
            self.submitButton?.bottomConstraint?.constant = self.submitButtonBottomSpace ?? 0
          }
    }

    private func animateBottomViewWith(offset: CGFloat) {
        submitButton?.bottomConstraint?.constant = offset
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension FormViewController: TextFieldDelegate {
    @objc open func textFieldEditingChanged(_ textField: TextField) {
        if let checkButton = view.subviews.compactMap({ $0 as? CheckButton }).first {
            submitButton?.isEnabled = (textFields?.allSatisfy { $0.validate() } ?? false) && checkButton.isChecked
            return
        }
        submitButton?.isEnabled = textFields?.allSatisfy { $0.validate() } ?? false
    }

    @objc open func textFieldShouldReturn(_ textField: TextField) -> Bool {
        if let activeFields = textFields, activeFields.count - 1 == activeTextField?.tag {
            textField.resignFirstResponder()
        } else {
            activeNextTextField()
        }
        return true
    }

    @objc open func textFieldDidBeginEditing(_ textField: TextField) {
        activeTextField = textField
        submitButton?.isEnabled = textFields?.allSatisfy { $0.validate() } ?? false
    }

    @objc open func textFieldDidEndEditing(_ textField: TextField) {
        activeTextField = nil
        submitButton?.isEnabled = textFields?.allSatisfy { $0.validate() } ?? false
    }
}

public extension FormViewController {
    func animateWithKeyboard(
        notification: NSNotification,
        animations: ((_ keyboardFrame: CGRect) -> Void)?
    ) {
        // Extract the duration of the keyboard animation
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = notification.userInfo![durationKey] as! Double
        
        // Extract the final frame of the keyboard
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrameValue = notification.userInfo![frameKey] as! NSValue
        
        // Extract the curve of the iOS keyboard animation
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = notification.userInfo![curveKey] as! Int
        let curve = UIView.AnimationCurve(rawValue: curveValue)!

        // Create a property animator to manage the animation
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            // Perform the necessary animation layout updates
            animations?(keyboardFrameValue.cgRectValue)
            
            // Required to trigger NSLayoutConstraint changes
            // to animate
            self.view?.layoutIfNeeded()
        }
        
        // Start the animation
        animator.startAnimation()
    }
}

