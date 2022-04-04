//
//  Button.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 11/02/22.
//

import UIKit

public class IconButton: Button {

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 20, height: 20)
    }

    public init(icon: UIImage?, action: (() -> Void)?) {
        super.init(style: .primary, title: "", isEnabled: true, action: action)
        backgroundColor = .clear
        setBackgroundImage(icon, for: .normal)
        imageView?.contentMode = .scaleToFill
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setIcon(_ icon: UIImage?) {
        setBackgroundImage(icon, for: .normal)
    }
}
