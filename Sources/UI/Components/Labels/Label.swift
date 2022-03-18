//
//  Label.swift
//  Alamofire
//
//  Created by Lucas Marques Bighi on 15/02/22.
//

import UIKit

public class Label: UILabel {

    public init(text: String?,
                font: UIFont = .primary(.regular, ofSize: 16),
                textColor: UIColor? = .primaryTextColor,
                textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = 0
        self.textAlignment = textAlignment
    }
    
    public init(html: String, font: UIFont = .primary(.regular, ofSize: 17)) {
        super.init(frame: .zero)
        
        var alignment: String {
            switch textAlignment {
            case .left:
                return "left"
            case .right:
                return "right"
            default:
                return "center"
            }
        }
        
//         let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)pt; color: \(alignment); line-height: \(lineheight)px; text-align: \(alignment); }</style>\(self)"
//         guard let data = modifiedString.data(using: .utf8) else { return }
//         do {
//             return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//         }
//         catch {
//             print(error)
//             return nil
//         }

        guard let encodedData = html.data(using: String.Encoding.utf8) else { return }
        let attributedOptions = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self.attributedText = attributedString
        } catch let error {
            print("Cannot create attributed String: \(error)")
        }
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.numberOfLines = 0
        self.textAlignment = textAlignment
    }
}
