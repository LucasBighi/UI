//
//  TitleLabel.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class SubtitleLabel: Label {

    public override init(text: String?,
                         textColor: UIColor? = .secondaryTextColor,
                         textAlignment: NSTextAlignment = .center) {
        super.init(text: text, textColor: textColor, textAlignment: textAlignment)
        commonInit(textColor: textColor)

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
