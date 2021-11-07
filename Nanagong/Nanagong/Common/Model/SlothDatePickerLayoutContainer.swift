//
//  SlothDatePickerLayoutContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/06.
//

import UIKit

struct SlothDatePickerViewLayoutContainer {
    
    let datePicker: DataPickerLayout = .init()
    let confirmButton: ConfirmButtonLayout = .init()
    
    var heightOfMargins: CGFloat {
        return datePicker.inset.top + confirmButton.inset.top + confirmButton.inset.bottom
    }
    
    struct DataPickerLayout {
        
        let datePickerMode: UIDatePicker.Mode = .date
        let preferredDatePickerStyle: UIDatePickerStyle = .inline
        let inset: UIEdgeInsets = .init(top: 32, left: 16, bottom: 0, right: 16)
        let tintColor: UIColor = .Sloth.primary400
    }
    
    struct ConfirmButtonLayout {
        
        let inset: UIEdgeInsets = .init(top: 8, left: 16, bottom: 32, right: 16)
    }
}
