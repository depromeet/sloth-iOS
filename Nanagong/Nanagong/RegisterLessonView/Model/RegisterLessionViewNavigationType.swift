//
//  RegisterLessionViewNavigationType.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import Foundation

enum RegisterLessionViewNavigationType {
    
    case none
    
    case categoryPicker(selected: IdNamePairType?)
    
    case sitePicker(selected: IdNamePairType?)
    
    case nextStep(currentLessonInformation: LessonInformation)
    
    case startDatePicker(prevSelected: Date?)
    
    case endDatePicker(prevSelected: Date?)
    
    case done
}
