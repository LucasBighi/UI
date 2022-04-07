//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 07/04/22.
//

import UIKit

public class BalanceLabel: Label {
    
    public var maskColor: UIColor? { .white }
    
    private var viewToMask: UIView!
    
    public var isMasked: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.viewToMask.alpha = self.isMasked ? 1 : 0
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        viewToMask.frame = bounds
    }
    
    public override init(text: String? = nil,
                         font: UIFont = .primary(.regular, ofSize: 16),
                         textColor: UIColor? = .primaryTextColor,
                         textAlignment: NSTextAlignment = .center) {
        super.init(text: text, font: font, textColor: textColor, textAlignment: textAlignment)
        commonInit()
    }
    
    public override init(html: String,
                         font: UIFont = .primary(.regular, ofSize: 16),
                         textColor: UIColor? = .primaryTextColor,
                         textAlignment: NSTextAlignment = .center) {
        super.init(html: html, font: font, textColor: textColor, textAlignment: textAlignment)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        viewToMask = UIView(frame: bounds, backgroundColor: maskColor)
        viewToMask.layer.cornerRadius = 10
        viewToMask.alpha = isMasked ? 1 : 0
        addSubview(viewToMask)
    }
}
