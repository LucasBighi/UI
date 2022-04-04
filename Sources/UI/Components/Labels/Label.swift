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
    
    public init(html: String,
                font: UIFont = .primary(.regular, ofSize: 16),
                textColor: UIColor? = .primaryTextColor,
                textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = 0
        setAttributes(with: html, andFont: font)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var html: String? {
        didSet {
            setAttributes(with: html, andFont: font)
        }
    }
    
    private func setAttributes(with html: String?, andFont font: UIFont = .primary(.regular, ofSize: 17)) {
        guard let encodedData = html?.data(using: .utf8) else { return }
        do {
            let attributedText = try NSMutableAttributedString(data: encodedData,
                                                               options: [.documentType: NSAttributedString.DocumentType.html,
                                                                         .characterEncoding: String.Encoding.utf8.rawValue],
                                                               documentAttributes: nil)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            attributedText.addAttributes([.font: font, .paragraphStyle: paragraphStyle],
                                         range: NSRange(location: 0, length: attributedText.length))
            
            if let bold = html?.slice(from: "<b>", to: "</b>"),
               let fontFamily = font.fontFamily,
               let boldFont = UIFont(name: "\(fontFamily)-Bold", size: font.pointSize),
               let boldRange = attributedText.string.range(of: bold) {
                attributedText.addAttribute(.font, value: boldFont, range: NSRange(boldRange, in: attributedText.string))
            }
            
            if let italic = html?.slice(from: "<i>", to: "</i>"),
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
}
