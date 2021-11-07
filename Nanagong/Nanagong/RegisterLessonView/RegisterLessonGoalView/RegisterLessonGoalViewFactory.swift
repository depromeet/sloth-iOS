//
//  RegisterLessonGoalViewFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import UIKit

final class RegisterLessonGoalViewFactory {

    private let layoutContainer: RegisterLessonViewLayoutContainer = .init()
    private let dependecy: SlothAppDependencyContainer
    private let prevLessonInformation: LessonInformation
    private let inputType: [SlothInputFormViewMeta] = [
        .init(inputFormType: .lessonStartDate, title: "강의 시작일", placeholder: ""),
        .init(inputFormType: .lessonEndDate, title: "완강 목표일", placeholder: ""),
        .init(inputFormType: .lessonPrice, title: "강의 금액", placeholder: "예) 10,000원"),
        .init(inputFormType: .lessonDetermination, title: "각오 한마디(선택)", placeholder: "")
    ]
    private lazy var viewModel: RegisterLessonGoalViewModel = makeRegisterLessonGoalViewModel()

    init(dependency: SlothAppDependencyContainer, prevLessonInformation: LessonInformation) {
        self.dependecy = dependency
        self.prevLessonInformation = prevLessonInformation
    }

    func makeRegisterLessonGoalViewController(coordinator: RegisterLessonGoalViewCoordinator) -> RegisterLessonViewController {
        return .init(viewModel: viewModel,
                     coordinator: coordinator,
                     registerLessonInputFormViewFactory: makeRegisterLessonGoalInputFormViewFactoryFactory())
    }
    
    func makeStartDatePickerViewController(_ prevSelectedDate: Date?) -> SlothDatePickerViewController {
        return .init(viewModel: makeStartDatePickerViewModel(prevSelectedDate))
    }
    
    func makeEndDatePickerViewController(_ prevSelectedDate: Date?, startDate: Date?) -> SlothDatePickerViewController {
        return .init(viewModel: makeEndDatePickerViewModel(prevSelectedDate, startDate: startDate))
    }
    
    private func makeRegisterLessonGoalInputFormViewFactoryFactory() -> RegisterLessonGoalInputFormViewFactory {
        return .init(with: viewModel)
    }

    private func makeRegisterLessonGoalViewModel() -> RegisterLessonGoalViewModel {
        return .init(inputType: inputType,
                     networkManager: dependecy.networkManager,
                     layoutContainer: layoutContainer,
                     prevLessonInformation: prevLessonInformation)
    }
    
    private func makeStartDatePickerViewModel(_ prevSelectedDate: Date?) -> SlothDatePickerViewModel {
        let datePickerViewModel = SlothDatePickerViewModel(prevSelectedDate: prevSelectedDate)
        viewModel.startDateDidSelected(datePickerViewModel.decidedDate.eraseToAnyPublisher())
        
        return datePickerViewModel
    }
    
    private func makeEndDatePickerViewModel(_ prevSelectedDate: Date?, startDate: Date?) -> SlothDatePickerViewModel {
        let datePickerViewModel = SlothDatePickerViewModel(prevSelectedDate: prevSelectedDate, startDate: startDate)
        viewModel.endDateDidSelected(datePickerViewModel.decidedDate.eraseToAnyPublisher())
        
        return datePickerViewModel
    }
}
