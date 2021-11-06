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
    private var selectedDate: Date = .init()
    
    init(prevSelectedDate: Date?) {
        self.prevSelectedDate = prevSelectedDate
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
