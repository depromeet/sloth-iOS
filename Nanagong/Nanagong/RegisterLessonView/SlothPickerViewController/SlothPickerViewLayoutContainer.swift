//
//  SlothPickerViewLayoutContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import UIKit

final class SlothPickerViewLayoutContainer {
    
    let pickerMargin: UIEdgeInsets = .init(top: 32, left: 0, bottom: 0, right: 0)
    
    let pickerHeight: CGFloat = 215
    
    let buttonMargin: UIEdgeInsets = .init(top: 8, left: 16, bottom: 32, right: 16)
    
    let buttonHeight: CGFloat = 56
    
    var totalHeight: CGFloat {
        return pickerMargin.top + buttonMargin.top + buttonMargin.bottom + pickerHeight + buttonHeight
    }
}
