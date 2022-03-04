//
//  EmailTextField.swift
//  UI
//
//  Created by Lucas Marques Bighi on 17/02/22.
//

import UIKit

public class DateTextField: TextField {

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()

    public var date = Date()

    public init(date: Date = Date(), placeholder: String? = nil) {
        super.init(text: date.toString(withFormat: .date), placeholder: placeholder)
        self.date = date
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        datePicker.date = date
        inputView = datePicker
        addTarget(self, action: #selector(changed), for: .editingDidEnd)
    }

    @objc
    private func changed() {
        text = datePicker.date.toString(withFormat: .date)
    }
}

extension Date {
    func toString(withFormat format: Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

public enum Format: String {
    /// 10:10
    case time = "HH:mm"
    /// 10/10/2010
    case date = "dd/MM/yyyy"
    /// 10/10/2010 10:10
    case dateAndTime = "dd/MM/yyyy HH:mm"
}
