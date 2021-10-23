//
//  RegisterLessonViewDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import UIKit

final class RegisterLessonViewDependencyContainer {
    
    private let appDependency: SlothAppDependencyContainer
    
    init(appDependency: SlothAppDependencyContainer) {
        self.appDependency = appDependency
    }
    
    func makeRegisterLessonViewController() -> RegisterLessonViewController {
        return RegisterLessonViewController(viewModel: makeRegisterLessonViewModel())
    }
    
    func makeRegisterLessonViewModel() -> RegisterLessionViewModel {
        return RegisterLessionViewModel(networkManager: appDependency.networkManager)
    }
}
