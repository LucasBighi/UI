//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 07/04/22.
//

import UIKit

public class BalanceLabel: Label {
    
    public var maskColor: UIColor? { .white }
    
    private var viewToMask: UIView!
    
    public var isMasked: Bool = false {
        didSet {
            viewToMask.isHidden = isMasked
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        viewToMask = UIView(frame: rect)
        viewToMask.layer.cornerRadius = 10
        addSubview(viewToMask)
    }
}
