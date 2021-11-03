//
//  OnBoardingViewControllerFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import UIKit

final class OnBoardingViewControllerFactory {
    
    private unowned var dependency: SlothAppDependencyContainer
    
    init(dependecy: SlothAppDependencyContainer) {
        self.dependency = dependecy
    }
    
    func makeOnBoardingViewController() -> OnBoardingViewController {
        return .init(dependencyContainer: makeOnBoardingDependencyContainer())
    }
    
    private func makeOnBoardingDependencyContainer() -> OnBoardingDependencyContainer {
        return OnBoardingDependencyContainer(dependency: dependency)
    }
}
