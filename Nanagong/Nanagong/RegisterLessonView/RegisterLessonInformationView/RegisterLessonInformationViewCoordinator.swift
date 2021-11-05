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
    private var viewController: RegisterLessonViewController?
    
    init(presenter: UINavigationController,
         viewContorllersFactory: RegisterLessonInformationViewControllerFacotry) {
        self.presenter = presenter
        self.viewContorllersFactory = viewContorllersFactory
    }
    
    func start() {
        let registerLessonInformationViewController = viewContorllersFactory.makeRegisterLessonViewController(coordinator: self)
        self.viewController = registerLessonInformationViewController
        presenter.pushViewController(registerLessonInformationViewController, animated: true)
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
            
        case .nextStep:
            print("next")
        
        default:
            break
        }
    }
}
