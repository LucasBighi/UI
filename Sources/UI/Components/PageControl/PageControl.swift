//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 14/03/22.
//

import UIKit

public protocol PageControlDelegate: NSObjectProtocol {
    func pageControlDidChangePage(_ pageControl: PageControl)
}

public class PageControl: UIPageControl {
    
    public weak var delegate: PageControlDelegate?
    
    private var lastPage = 0
    
    public init(numberOfPages: Int) {
        super.init(frame: .zero)
        self.numberOfPages = numberOfPages
        self.currentPage = 0
        self.currentPageIndicatorTintColor = #colorLiteral(red: 0.937254902, green: 0.1725490196, blue: 0.2274509804, alpha: 1)
        self.pageIndicatorTintColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        self.addTarget(self, action: #selector(changePage(_:)), for: .valueChanged)
    }
    
    @objc private func changePage(_ sender: PageControl) {
        delegate?.pageControlDidChangePage(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
