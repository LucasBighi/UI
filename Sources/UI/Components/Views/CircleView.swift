//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 04/04/22.
//

import UIKit

class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = rect.width / 2
    }
}
