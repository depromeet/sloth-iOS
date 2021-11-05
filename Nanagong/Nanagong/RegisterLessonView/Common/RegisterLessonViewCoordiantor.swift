//
//  RegisterLessonViewCoordiantor.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/01.
//

import Foundation

protocol RegisterLessonViewCoordinator: AnyObject, Coordinator {
    
    func navigate(with navigationType: RegisterLessionViewNavigationType)
}
