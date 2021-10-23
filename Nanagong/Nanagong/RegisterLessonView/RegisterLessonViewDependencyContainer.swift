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
        return RegisterLessonViewController(viewModel: makeRegisterLessonViewModel(), makeSlothInputFormView: makeSlothInputFormView(with:))
    }
    
    func makeRegisterLessonViewModel() -> RegisterLessionViewModel {
        return RegisterLessionViewModel(networkManager: appDependency.networkManager)
    }
    
    func makeSlothInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothInputFormView {
        return SlothInputFormView(viewModel: makeSlothInputFormViewModel(with: viewMeta))
    }
    
    func makeSlothInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothInputFormViewModel {
        return SlothInputFormViewModel(viewMeta: viewMeta)
    }
}
