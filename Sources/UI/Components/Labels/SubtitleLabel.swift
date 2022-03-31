//
//  TitleLabel.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class SubtitleLabel: Label {

    public init(text: String?,
                textColor: UIColor? = .secondaryTextColor,
                font: UIFont = UI.theme.subtitleFont,
                textAlignment: NSTextAlignment = .center) {
        super.init(text: text, font: font, textColor: textColor, textAlignment: textAlignment)
        commonInit(textColor: textColor)

    }
    
    public init(html: String,
                textColor: UIColor? = .secondaryTextColor,
                font: UIFont = UI.theme.subtitleFont,
                textAlignment: NSTextAlignment = .center) {
        super.init(html: html, font: UI.theme.subtitleFont, textColor: textColor, textAlignment: textAlignment)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(textColor: .secondaryTextColor)
    }

    private func commonInit(textColor: UIColor?) {
        func labelStyle(_ l: UILabel) {
            l.font = UI.theme.subtitleFont
            l.textColor = textColor
        }

        style(labelStyle)
    }
}
