//
//  RegisterLessonGoalInputFormViewFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import UIKit

final class RegisterLessonGoalInputFormViewFactory: RegisterLessonInputFormViewFactory {

    private unowned var parentViewModel: RegisterLessonGoalViewModel

    init(with parenViewModel: RegisterLessonGoalViewModel) {
        self.parentViewModel = parenViewModel
    }

    func makeInputFormView(with viewMeta: SlothInputFormViewMeta) -> UIView {
        switch viewMeta.inputFormType {
        case .lessonStartDate:
            return makeStartDateInputFormView(with: viewMeta)

        case .lessonEndDate:
            return makeEndDateInputFormView(with: viewMeta)
            
        case .lessonPrice:
            return makePriceInputFormView(with: viewMeta)
            
        default:
            return UIView()
        }
    }

    private func makeStartDateInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothSelectDateInputFormView {
        return SlothSelectDateInputFormView(viewModel: makeStartDateInputFormViewModel(with: viewMeta))
    }
    
    private func makeEndDateInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothSelectDateInputFormView {
        return SlothSelectDateInputFormView(viewModel: makeEndDateInputFormViewModel(with: viewMeta))
    }
    
    private func makePriceInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothTextFieldInputFormView {
        return SlothTextFieldInputFormView(viewModel: makePriceInputFormViewModel(with: viewMeta))
    }
    
    private func makeDeterminationInputFormView(with viewMeta: SlothInputFormViewMeta) -> SlothTextFieldInputFormView {
        return SlothTextFieldInputFormView(viewModel: makePriceInputFormViewModel(with: viewMeta))
    }

    private func makeStartDateInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothSelectDateInputFormViewModel {
        let viewModel = SlothSelectDateInputFormViewModel(viewMeta: viewMeta,
                                                          dateSelected: parentViewModel.$selectedStartDate.eraseToAnyPublisher())
        parentViewModel.bindWithSelectStartDateView(viewModel.$state.eraseToAnyPublisher())

        return viewModel
    }

    private func makeEndDateInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothSelectDateInputFormViewModel {
        let viewModel = SlothSelectDateInputFormViewModel(viewMeta: viewMeta,
                                                          dateSelected: parentViewModel.$selectedEndDate.eraseToAnyPublisher())
        parentViewModel.bindWithSelectEndDateView(viewModel.$state.eraseToAnyPublisher())

        return viewModel
    }
    
    private func makePriceInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothPriceInputFormViewModel {
        let viewModel = SlothPriceInputFormViewModel(viewMeta: viewMeta)
        parentViewModel.bindWithPriceView(viewModel.$state.eraseToAnyPublisher())

        return viewModel
    }
    
    private func makeDeterminationInputFormViewModel(with viewMeta: SlothInputFormViewMeta) -> SlothDeterminationInputFormViewModel {
        let viewModel = SlothDeterminationInputFormViewModel(viewMeta: viewMeta)
        parentViewModel.bindWithDetermination(viewModel.$state.eraseToAnyPublisher())

        return viewModel
    }
}

