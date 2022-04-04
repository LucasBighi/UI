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
    }
    
    public override init(html: String,
                         font: UIFont = UI.theme.titleFont,
                         textColor: UIColor? = .primaryTextColor,
                         textAlignment: NSTextAlignment = .center) {
        super.init(html: html, font: font)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
