//
//  TitleLabel.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class HeaderLabel: Label {

    public override init(text: String?,
                         textColor: UIColor? = .primaryTextColor,
                         textAlignment: NSTextAlignment = .center) {
        super.init(text: text, textColor: textColor, textAlignment: textAlignment)
        commonInit(textColor: textColor)
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
