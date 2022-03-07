//
//  Label.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class Label: UILabel {

    public init(text: String?,
                textColor: UIColor? = .primaryTextColor,
                textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.numberOfLines = 0
        self.textAlignment = textAlignment
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.numberOfLines = 0
        self.textAlignment = textAlignment
    }
}
