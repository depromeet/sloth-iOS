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
    
    func makeSlothInputFormView(with inputType: InputType) -> UIView {
        switch inputType {
        case .text(let textType):
            return makeSlothTextFieldInputFormView(with: textType)
            
        case .selectBox(let selectBoxType):
            return makeSlothSelectBoxInputFormView(with: selectBoxType)
        }
        
    }
    
    private func makeSlothTextFieldInputFormView(with textInputType: InputType.Text) -> SlothTextFieldInputFormView {
        return SlothTextFieldInputFormView(viewModel: makeSlothTextFieldInputFormViewModel(with: textInputType))
    }
    
    private func makeSlothSelectBoxInputFormView(with selectBoxInputType: InputType.SelectBox) -> SlothSelectBoxInputFormView {
        return SlothSelectBoxInputFormView(viewModel: makeSlothSelectBoxInputFormViewModel(with: selectBoxInputType))
    }
    
    private func makeSlothTextFieldInputFormViewModel(with textInputType: InputType.Text) -> SlothTextFieldInputFormViewModel {
        return SlothTextFieldInputFormViewModel(textInputType: textInputType)
    }
    
    private func makeSlothSelectBoxInputFormViewModel(with selectBoxInputType: InputType.SelectBox) -> SlothSelectBoxInputFormViewModel {
        return SlothSelectBoxInputFormViewModel(selectBoxInputType: selectBoxInputType)
    }
}
