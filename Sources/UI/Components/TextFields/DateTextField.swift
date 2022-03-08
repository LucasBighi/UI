//
//  EmailTextField.swift
//  UI
//
//  Created by Lucas Marques Bighi on 17/02/22.
//

import UIKit

public class DateTextField: TextField {
    
    private var format: Date.Format = .date

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

    public init(date: Date = Date(), dateFormat: Date.Format = .date, placeholder: String? = nil) {
        super.init(text: date.toString(withFormat: dateFormat), placeholder: placeholder)
        self.date = date
        self.format = dateFormat
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
        text = datePicker.date.toString(withFormat: format)
    }
}

public extension Date {
    func toString(withFormat format: Format) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate(format.rawValue)
        return formatter.string(from: self)
    }
    
    enum Format: String {
        /// 10:10
        case time = "HH:mm"
        /// 10/10/2010
        case date = "dd/MM/yyyy"
        /// 10/10/2010 10:10
        case dateAndTime = "dd/MM/yyyy HH:mm"
    }
}
