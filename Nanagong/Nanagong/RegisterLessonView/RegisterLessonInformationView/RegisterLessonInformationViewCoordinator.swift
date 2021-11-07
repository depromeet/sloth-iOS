//
//  RegisterLessonInformationViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/31.
//

import UIKit

final class RegisterLessonInformationViewCoordinator: RegisterLessonViewCoordinator {
    
    private let viewContorllersFactory: RegisterLessonInformationViewControllerFacotry
    private let presenter: UINavigationController
    private let dependency: SlothAppDependencyContainer
    private var viewController: RegisterLessonViewController?
    private var registerLessonGoalViewCoordinator: RegisterLessonGoalViewCoordinator?
    
    init(presenter: UINavigationController, dependency: SlothAppDependencyContainer) {
        self.presenter = presenter
        self.dependency = dependency
        self.viewContorllersFactory = .init(appDependency: dependency)
    }
    
    func start() {
        let registerLessonInformationViewController = viewContorllersFactory.makeRegisterLessonViewController(coordinator: self)
        self.viewController = registerLessonInformationViewController
//        presenter.pushViewController(registerLessonInformationViewController, animated: true)
        presenter.viewControllers = [registerLessonInformationViewController]
    }
    
    func navigate(with navigationType: RegisterLessionViewNavigationType) {
        switch navigationType {
        case .categoryPicker(let selected):
            let categoryPicker = viewContorllersFactory.makeLessonCategoryPicker(prevSelected: selected)
            viewController?.present(categoryPicker,
                                    animated: true,
                                    completion: nil)
            
        case .sitePicker(let selected):
            let sitePicker = viewContorllersFactory.makeLessonSitePicker(prevSelected: selected)
            viewController?.present(sitePicker,
                                    animated: true,
                                    completion: nil)
            
        case .nextStep(let prevLessonInformation):
            let registerLessonGoalViewCoordinator = RegisterLessonGoalViewCoordinator(presenter: presenter,
                                                                                      dependecy: dependency,
                                                                                      prevLessonInformation: prevLessonInformation)
            self.registerLessonGoalViewCoordinator = registerLessonGoalViewCoordinator
            viewController?.navigationItem.backButtonDisplayMode = .minimal
            viewController?.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
            viewController?.navigationItem.backBarButtonItem?.tintColor = .black
            registerLessonGoalViewCoordinator.start()
        
        default:
            break
        }
    }
}
