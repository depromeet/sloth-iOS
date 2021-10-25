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
        return RegisterLessonViewController(viewModel: makeRegisterLessonViewModel(),
                                            registerLessonInputFormViewFactory: makeRegisterLessonInputFormViewFactory())
    }
    
    func makeRegisterLessonViewModel() -> RegisterLessionViewModel {
        return RegisterLessionViewModel(networkManager: appDependency.networkManager)
    }
    
    func makeRegisterLessonInputFormViewFactory() -> RegisterLessonInputFormViewFactory {
        return RegisterLessonInputFormViewFactory()
    }
}

final class RegisterLessonInputFormViewFactory {
    
    func makeSlothInputFormView(with viewMeta: SlothInputFormViewMeta) -> UIView {
        switch viewMeta.inputType {
        case .name:
            return makeSlothTextFieldInputFormView(with: viewMeta)
            
        case .numberOfLessons:
            return makeSlothTextFieldInputFormView(with: viewMeta)
            
        case .cateogry:
            return makeSlothSelectBoxInputFormView(with: viewMeta)
            
        case .site:
            return makeSlothSelectBoxInputFormView(with: viewMeta)
        }
    }
    
    private func makeSlothTextFieldInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothTextFieldInputFormView {
        return SlothTextFieldInputFormView(viewModel: makeSlothTextFieldInputFormViewModel(with: viewMeta))
    }
    
    private func makeSlothSelectBoxInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothSelectBoxInputFormView {
        return SlothSelectBoxInputFormView(viewModel: makeSlothSelectBoxInputFormViewModel(with: viewMeta))
    }
    
    private func makeSlothTextFieldInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothTextFieldInputFormViewModel {
        return SlothTextFieldInputFormViewModel(viewMeta: viewMeta)
    }
    
    private func makeSlothSelectBoxInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothSelectBoxInputFormViewModel {
        return SlothSelectBoxInputFormViewModel(viewMeta: viewMeta)
    }
}
