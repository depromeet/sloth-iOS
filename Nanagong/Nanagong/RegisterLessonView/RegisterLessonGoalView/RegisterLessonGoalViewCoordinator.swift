//
//  RegisterLessonGoalViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/05.
//

import UIKit

final class RegisterLessonGoalViewCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let dependecy: SlothAppDependencyContainer
    private let prevLessonInformation: LessonInformation
    
    init(presenter: UINavigationController,
         dependecy: SlothAppDependencyContainer,
         prevLessonInformation: LessonInformation) {
        self.presenter = presenter
        self.dependecy = dependecy
        self.prevLessonInformation = prevLessonInformation
    }
    
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        presenter.pushViewController(viewController, animated: true)
    }
}
