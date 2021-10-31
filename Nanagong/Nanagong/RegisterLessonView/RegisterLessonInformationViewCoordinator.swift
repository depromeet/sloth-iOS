//
//  RegisterLessonInformationViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/31.
//

import UIKit

final class RegisterLessonInformationViewCoordinator: Coordinator {
    
    private let viewContorllersFactory: RegisterLessonViewControllersFacotry
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController,
         viewContorllersFactory: RegisterLessonViewControllersFacotry) {
        self.presenter = presenter
        self.viewContorllersFactory = viewContorllersFactory
    }
    
    func start() {
        let registerLessonInformationViewController = viewContorllersFactory.makeRegisterLessonViewController()
        presenter.pushViewController(registerLessonInformationViewController, animated: true)
    }
}
