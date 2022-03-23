//
//  File.swift
//  
//
//  Created by Lucas Marques Bighi on 16/03/22.
//

import UIKit

public class Alert: UIAlertController {
    
    public init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.message = message

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Alert {
    func action(_ title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Alert {
        let alert = self
        alert.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return alert
    }
    
    func textField(configurationHandler: ((UITextField) -> Void)? = nil) -> Alert {
        let alert = self
        alert.addTextField(configurationHandler: configurationHandler)
        return alert
    }
    
    func present(in viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: true, completion: completion)
    }
}
