//
//  RegisterLessonNextButtonStateType.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import UIKit

protocol RegisterLessonNextButtonStateType {
    
    var buttonConstraint: UIEdgeInsets { get set }
    var isEnabled: Bool { get set }
    var isRoundCorner: Bool { get set }
}
