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
    }
}
