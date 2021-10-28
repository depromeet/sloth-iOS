//
//  RegisterLessonViewDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import UIKit

final class RegisterLessonViewDependencyContainer {
    
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
                                            registerLessonInputFormViewFactory: inputFormViewFactory)
    }
    
    func makeRegisterLessonViewModel() -> RegisterLessionViewModel {
        return RegisterLessionViewModel(inputType: inputType,
                                        networkManager: appDependency.networkManager,
                                        layoutContainer: layoutContainer)
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
            return makeNameInputFormView(with: viewMeta)
            
        case .numberOfLessons:
            return makeNumberOfLessonsInputFormView(with: viewMeta)
            
        case .lessonCategory:
            return makeCategoryInputFormView(with: viewMeta)
            
        case .lessonSite:
            return makeSiteInputFormView(with: viewMeta)
        }
    }
    
    private func makeNameInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothTextFieldInputFormView {
        return SlothTextFieldInputFormView(viewModel: makeNameInputFormViewModel(with: viewMeta))
    }
    
    private func makeNumberOfLessonsInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothTextFieldInputFormView {
        return SlothTextFieldInputFormView(viewModel: makeNumberOfLessonsInputFormViewModel(with: viewMeta))
    }
    
    private func makeCategoryInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothSelectBoxInputFormView {
        return SlothSelectBoxInputFormView(viewModel: makeCategoryInputFormViewModel(with: viewMeta))
    }
    
    private func makeSiteInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothSelectBoxInputFormView {
        
        return SlothSelectBoxInputFormView(viewModel: makeSiteInputFormViewModel(with: viewMeta))
    }
        
    private func makeNameInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothNameInputFormViewModel {
        let viewModel = SlothNameInputFormViewModel(viewMeta: viewMeta)
        parentViewModel.bindWithNameValidator(viewModel.$isValidate.eraseToAnyPublisher())
        
        return viewModel
    }
    
    private func makeNumberOfLessonsInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothNumberOfLessonsInputFormViewModel {
        let viewModel = SlothNumberOfLessonsInputFormViewModel(viewMeta: viewMeta)
        parentViewModel.bindWithNumberOfLessonsValidator(viewModel.$isValidate.eraseToAnyPublisher())
        
        return viewModel
    }
    
    private func makeCategoryInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothCategoryInputFormViewModel {
        let viewModel = SlothCategoryInputFormViewModel(viewMeta: viewMeta, inputSelected: parentViewModel.$selectedCategory.eraseToAnyPublisher())
        parentViewModel.cateogrySelectBoxTapped(viewModel.tapped.eraseToAnyPublisher())
        
        return viewModel
    }
    
    private func makeSiteInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothSiteInputFormViewModel {
        let viewModel = SlothSiteInputFormViewModel(viewMeta: viewMeta, inputSelected: parentViewModel.$selectedSite.eraseToAnyPublisher())
        parentViewModel.siteSelecBoxTapped(viewModel.tapped.eraseToAnyPublisher())
        
        return viewModel
    }
}
