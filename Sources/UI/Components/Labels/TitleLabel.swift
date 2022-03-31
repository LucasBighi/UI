//
//  TitleLabel.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class TitleLabel: Label {

    public override init(text: String?,
                font: UIFont = UI.theme.titleFont,
                textColor: UIColor? = .primaryTextColor,
                textAlignment: NSTextAlignment = .center) {
        super.init(text: text, font: font, textColor: textColor, textAlignment: textAlignment)
        commonInit(textColor: textColor)

    }
    
    public init(html: String) {
        super.init(html: html, font: UI.theme.titleFont)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(textColor: .primaryTextColor)
    }

    private func commonInit(textColor: UIColor?) {
        func labelStyle(_ l: UILabel) {
            l.font = UI.theme.titleFont
            l.textColor = textColor
        }

        style(labelStyle)
    }
}
