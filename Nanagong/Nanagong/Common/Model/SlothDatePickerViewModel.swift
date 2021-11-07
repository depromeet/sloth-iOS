//
//  SlothDatePickerViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/06.
//

import Combine
import UIKit

final class SlothDatePickerViewModel {
    
    let decidedDate: PassthroughSubject<Date, Never> = .init()
    let prevSelectedDate: Date?
    let startDate: Date?
    private var selectedDate: Date = .init()
    
    init(prevSelectedDate: Date?, startDate: Date? = nil) {
        self.prevSelectedDate = prevSelectedDate
        self.startDate = startDate
    }
    
    @objc
    func confirmButtonTapped() {
        decidedDate.send(selectedDate)
    }
    
    @objc
    func dateSelected(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
}
