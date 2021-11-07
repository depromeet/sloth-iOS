//
//  RegisterLessonInputForm.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import UIKit

enum RegisterInputFormType {
    
    case lessonName
    
    case numberOfLessons
    
    case lessonCategory
    
    case lessonSite
    
    case lessonStartDate
    
    case lessonEndDate
    
    case lessonPrice
    
    case lessonDetermination
    
    var keyBoardType: UIKeyboardType {
        switch self {
        case .numberOfLessons,
                .lessonPrice:
            return .numberPad
            
        default:
            return .default
        }
    }
}
