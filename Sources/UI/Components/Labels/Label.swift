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

        guard let encodedData = html.data(using: .utf8) else { return }
        let attributedOptions = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            let attributedText = try NSMutableAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            attributedText.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedText.length))
            
            if let bold = html.slice(from: "<b>", to: "</b>"),
               let fontFamily = font.fontFamily,
               let boldFont = UIFont(name: "\(fontFamily)-Bold", size: font.pointSize),
               let boldRange = attributedText.string.range(of: bold) {
                attributedText.addAttribute(.font, value: boldFont, range: NSRange(boldRange, in: attributedText.string))
            }
            
            if let italic = html.slice(from: "<i>", to: "</i>"),
               let fontFamily = font.fontFamily,
               let italicFont = UIFont(name: "\(fontFamily)-Italic", size: font.pointSize),
               let italicRange = attributedText.string.range(of: italic) {
                attributedText.addAttribute(.font, value: italicFont, range: NSRange(italicRange, in: attributedText.string))
            }
            
            self.attributedText = attributedText
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

extension String {
    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom..<rangeTo])
    }
}

//extension String {
//    func slice(from: String, to: String) -> String? {
//        return (range(of: from)?.upperBound).flatMap { substringFrom in
//            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
//                String(self[substringFrom..<substringTo])
//            }
//        }
//    }
//}
