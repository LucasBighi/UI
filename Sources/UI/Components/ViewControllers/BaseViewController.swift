//
//  BaseViewController.swift
//  Pods-UI_Example
//
//  Created by Lucas Marques Bighi on 11/02/22.
//

import UIKit

open class BaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.theme?.viewControllerBackgroundColor
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.subviews.forEach { $0.endEditing(true) }
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}


