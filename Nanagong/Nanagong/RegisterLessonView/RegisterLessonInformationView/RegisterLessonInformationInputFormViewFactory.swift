//
//  RegisterLessonInputFormViewFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/01.
//

import UIKit

final class RegisterLessonInformationInputFormViewFactory: RegisterLessonInputFormViewFactory {
    
    private unowned var parentViewModel: RegisterLessionInformationViewModel
    
    init(with parenViewModel: RegisterLessionInformationViewModel) {
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
            
        default:
            return UIView()
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
        parentViewModel.bindWithNameViewState(viewModel.$state.eraseToAnyPublisher())
        
        return viewModel
    }
    
    private func makeNumberOfLessonsInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothNumberOfLessonsInputFormViewModel {
        let viewModel = SlothNumberOfLessonsInputFormViewModel(viewMeta: viewMeta)
        parentViewModel.bindWithNumberOfLessonsViewState(viewModel.$state.eraseToAnyPublisher())
        
        return viewModel
    }
    
    private func makeCategoryInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothCategoryInputFormViewModel {
        let viewModel = SlothCategoryInputFormViewModel(viewMeta: viewMeta, inputSelected: parentViewModel.$selectedCategory.eraseToAnyPublisher())
        parentViewModel.bindWithCategorySelectViewState(viewModel.$state.eraseToAnyPublisher())
        
        return viewModel
    }
    
    private func makeSiteInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothSiteInputFormViewModel {
        let viewModel = SlothSiteInputFormViewModel(viewMeta: viewMeta, inputSelected: parentViewModel.$selectedSite.eraseToAnyPublisher())
        parentViewModel.bindWithSiteSelectViewState(viewModel.$state.eraseToAnyPublisher())
        
        return viewModel
    }
}
