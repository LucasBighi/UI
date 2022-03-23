//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 17/03/22.
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
