//
//  RegisterLessonViewControllersFacotry.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import UIKit

final class RegisterLessonViewControllersFacotry {
    
    private let layoutContainer: RegisterLessonViewLayoutContainer = .init()
    private let appDependency: SlothAppDependencyContainer
    private let inputType: [SlothInputFormViewMeta] = [
        .init(inputFormType: .lessonName,
              title: "강의 이름",
              placeholder: "수강할 인강 이름을 입력하세요."),
        .init(inputFormType: .numberOfLessons,
              title: "강의 개수",
              placeholder: "전체 강의 개수를 입력하세요."),
        .init(inputFormType: .lessonCategory,
              title: "카테고리",
              placeholder: "인강 카테고리를 선택하세요."),
        .init(inputFormType: .lessonSite,
              title: "강의 사이트",
              placeholder: "강의 사이트를 선택하세요.")
    ]
    
    init(appDependency: SlothAppDependencyContainer) {
        self.appDependency = appDependency
    }
    
    func makeRegisterLessonViewController() -> RegisterLessonViewController {
        let viewModel = makeRegisterLessonViewModel()
        let inputFormViewFactory = makeRegisterLessonInputFormViewFactory(with: viewModel)
        
        return RegisterLessonViewController(viewModel: viewModel,
                                            registerLessonInputFormViewFactory: inputFormViewFactory,
                                            viewControllerFactory: makeRegisterLessonViewControllerFactory(parentViewModel: viewModel))
    }
    
    private func makeRegisterLessonViewModel() -> RegisterLessionInformationViewModel {
        return RegisterLessionInformationViewModel(inputType: inputType,
                                        networkManager: appDependency.networkManager,
                                        layoutContainer: layoutContainer)
    }
    
    private func makeRegisterLessonInputFormViewFactory(with parentViewModel: RegisterLessionInformationViewModel) -> RegisterLessonInputFormViewFactory {
        return RegisterLessonInputFormViewFactory(with: parentViewModel)
    }
    
    private func makeRegisterLessonViewControllerFactory(parentViewModel: RegisterLessionInformationViewModel) -> RegisterLessonInformationViewPickerFactory {
        return RegisterLessonInformationViewPickerFactory(appDependancyContainer: appDependency, parentViewModel: parentViewModel)
    }
}
