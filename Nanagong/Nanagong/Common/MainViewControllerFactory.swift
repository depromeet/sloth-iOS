//
//  MainViewControllerFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import UIKit

final class MainViewControllerFactory {
    
    private let dependency: SlothAppDependencyContainer
    
    init(dependency: SlothAppDependencyContainer) {
        self.dependency = dependency
    }
    
    func makeMainViewControlelr(_ coordinator: AppCoordinator) -> MainViewController {
        return .init(coordinator: coordinator, viewModel: makeMainViewModel())
    }
    
    private func makeMainViewModel() -> MainViewModel {
        return .init(dependecy: dependency)
    }
}
