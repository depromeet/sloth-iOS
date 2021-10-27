//
//  RegisterLessonViewDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import UIKit

final class RegisterLessonViewDependencyContainer {
    
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
                                            registerLessonInputFormViewFactory: inputFormViewFactory)
    }
    
    func makeRegisterLessonViewModel() -> RegisterLessionViewModel {
        return RegisterLessionViewModel(inputType: inputType,
                                        networkManager: appDependency.networkManager)
    }
    
    func makeRegisterLessonInputFormViewFactory(with parentViewModel: RegisterLessionViewModel) -> RegisterLessonInputFormViewFactory {
        return RegisterLessonInputFormViewFactory(with: parentViewModel)
    }
}

final class RegisterLessonInputFormViewFactory {
    
    private unowned var parentViewModel: RegisterLessionViewModel
    
    init(with parenViewModel: RegisterLessionViewModel) {
        self.parentViewModel = parenViewModel
    }
        
    func makeInputFormView(with viewMeta: SlothInputFormViewMeta) -> UIView {
        switch viewMeta.inputFormType {
        case .lessonName:
            return makeNameViewInputFormView(with: viewMeta, parentViewModel: parentViewModel)
            
        case .numberOfLessons:
            return makeNumberOfLessonsInputFormView(with: viewMeta, parentViewModel: parentViewModel)
            
        case .lessonCategory:
            return makeCategoryInputFormView(with: viewMeta, parentViewModel: parentViewModel)
            
        case .lessonSite:
            return makeSiteInputFormView(with: viewMeta, parentViewModel: parentViewModel)
        }
    }
    
    private func makeNameViewInputFormView(with viewMeta: SlothInputFormViewMeta,
                                           parentViewModel: RegisterLessionViewModel) -> SlothTextFieldInputFormView {
        let viewModel = makeNameViewInputFormViewModel(with: viewMeta)
        parentViewModel.bindWithNameValidator(viewModel.$isValidate.eraseToAnyPublisher())

        return SlothTextFieldInputFormView(viewModel: viewModel)
    }
    
    private func makeNumberOfLessonsInputFormView(with viewMeta: SlothInputFormViewMeta,
                                                  parentViewModel: RegisterLessionViewModel) -> SlothTextFieldInputFormView {
        let viewModel = makeNumberOfLessonsInputFormViewModel(with: viewMeta)
        parentViewModel.bindWithNumberOfLessonsValidator(viewModel.$isValidate.eraseToAnyPublisher())
        
        return SlothTextFieldInputFormView(viewModel: viewModel)
    }
    
    private func makeCategoryInputFormView(with viewMeta: SlothInputFormViewMeta,
                                           parentViewModel: RegisterLessionViewModel) -> SlothSelectBoxInputFormView {
        let viewModel = makeCategoryInputFormViewModel(with: viewMeta)
        parentViewModel.cateogrySelectBoxTapped(viewModel.tapped.eraseToAnyPublisher())
        
        return SlothSelectBoxInputFormView(viewModel: viewModel)
    }
    
    private func makeSiteInputFormView(with viewMeta: SlothInputFormViewMeta,
                                       parentViewModel: RegisterLessionViewModel) -> SlothSelectBoxInputFormView {
        let viewModel = makeSiteInputFormViewModel(with: viewMeta)
        parentViewModel.siteSelecBoxTapped(viewModel.tapped.eraseToAnyPublisher())
        
        return SlothSelectBoxInputFormView(viewModel: viewModel)
    }
    
    private func makeNameViewInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothNameInputFormViewModel {
        return SlothNameInputFormViewModel(viewMeta: viewMeta)
    }
    
    private func makeNumberOfLessonsInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothNumberOfLessonsInputFormViewModel {
        return SlothNumberOfLessonsInputFormViewModel(viewMeta: viewMeta)
    }
    
    private func makeCategoryInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothCategoryInputFormViewModel {
        return SlothCategoryInputFormViewModel(viewMeta: viewMeta)
    }
    
    private func makeSiteInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothSiteInputFormViewModel {
        return SlothSiteInputFormViewModel(viewMeta: viewMeta)
    }
}
