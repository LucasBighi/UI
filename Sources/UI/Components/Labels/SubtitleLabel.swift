//
//  TitleLabel.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class SubtitleLabel: Label {

    public override init(text: String?, textAlignment: NSTextAlignment = .center) {
        super.init(text: text, textAlignment: textAlignment)
        commonInit()

    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        func labelStyle(_ l: UILabel) {
            l.font = Theme.theme.subtitleFont
            l.textColor = Theme.theme.secondaryTextColor
        }

        style(labelStyle)
    }
}
