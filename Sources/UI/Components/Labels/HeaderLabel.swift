//
//  TitleLabel.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class HeaderLabel: Label {

    public init(text: String?,
                         textColor: UIColor? = .primaryTextColor,
                         textAlignment: NSTextAlignment = .center) {
        super.init(text: text, font: UI.theme.headerFont, textColor: textColor, textAlignment: textAlignment)
        commonInit(textColor: textColor)
    }
    
    public override init(html: String, font: UIFont = .primary(.regular, ofSize: 17)) {
        super.init(html: html, font: font)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(textColor: textColor)
    }

    private func commonInit(textColor: UIColor?) {
        func labelStyle(_ l: UILabel) {
            l.font = UI.theme.headerFont
            l.textColor = textColor
        }
        
        style(labelStyle)
    }
}
