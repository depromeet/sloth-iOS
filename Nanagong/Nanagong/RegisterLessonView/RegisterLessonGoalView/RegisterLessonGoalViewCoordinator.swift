//
//  RegisterLessonGoalViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/05.
//

import UIKit

final class RegisterLessonGoalViewCoordinator: RegisterLessonViewCoordinator {

    private let presenter: UINavigationController
    private let dependecy: SlothAppDependencyContainer
    private let prevLessonInformation: LessonInformation
    private let viewFactory: RegisterLessonGoalViewFactory
    private var viewController: RegisterLessonViewController?
    
    init(presenter: UINavigationController,
         dependecy: SlothAppDependencyContainer,
         prevLessonInformation: LessonInformation) {
        self.presenter = presenter
        self.dependecy = dependecy
        self.prevLessonInformation = prevLessonInformation
        self.viewFactory = .init(dependency: dependecy, prevLessonInformation: prevLessonInformation)
    }
    
    func start() {
        let viewController = viewFactory.makeRegisterLessonGoalViewController(coordinator: self)
        self.viewController = viewController
        
        presenter.pushViewController(viewController, animated: true)
    }
    
    func navigate(with navigationType: RegisterLessionViewNavigationType) {
        switch navigationType {
        case .startDatePicker(let prevSelected):
            let startDatePickerViewController = viewFactory.makeStartDatePickerViewController(prevSelected)
            startDatePickerViewController.modalPresentationStyle = .custom
            startDatePickerViewController.transitioningDelegate = startDatePickerViewController
            viewController?.present(startDatePickerViewController, animated: true, completion: nil)
            
        case .endDatePicker(let prevSelected):
            let endDatePickerViewController = viewFactory.makeEndDatePickerViewController(prevSelected)
            endDatePickerViewController.modalPresentationStyle = .custom
            endDatePickerViewController.transitioningDelegate = endDatePickerViewController
            viewController?.present(endDatePickerViewController, animated: true, completion: nil)
            
        case .done:
            break
            
        default:
            break
        }
    }
}
