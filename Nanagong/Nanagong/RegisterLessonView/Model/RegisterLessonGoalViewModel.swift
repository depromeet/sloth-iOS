//
//  RegisterLessonGoalViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import Combine
import UIKit
import SlothNetworkModule

final class RegisterLessonGoalViewModel: RegisterLessonViwModelType {
    
    @Published var selectedStartDate: Date = .init()
    @Published var selectedEndDate: Date = .init()
    
    var inset: UIEdgeInsets {
        return layoutContainer.inset
    }
    let currentInputFormMeta: PassthroughSubject<SlothInputFormViewMeta, Never> = .init()
    let nextButtonState: CurrentValueSubject<RegisterLessonNextButtonState, Never>
    let progress: PassthroughSubject<Float, Never> = .init()
    let navigation: PassthroughSubject<RegisterLessionViewNavigationType, Never> = .init()
    
    private var inputType: [SlothInputFormViewMeta]
    private let networkManager: NetworkManager
    private let layoutContainer: RegisterLessonViewLayoutContainer
    private var totalInputTypeCount: Int
    private var lessonInformation: LessonInformation
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(inputType: [SlothInputFormViewMeta],
         networkManager: NetworkManager,
         layoutContainer: RegisterLessonViewLayoutContainer,
         prevLessonInformation: LessonInformation) {
        self.inputType = inputType
        self.totalInputTypeCount = inputType.count
        self.networkManager = networkManager
        self.layoutContainer = layoutContainer
        self.lessonInformation = prevLessonInformation
        self.nextButtonState = .init(
            .init(buttonConstraint: layoutContainer.inset,
                  isEnabled: false,
                  isRoundCorner: true)
        )
    }
    
    func retrieveRegisterLessonForm() {
        currentInputFormMeta.send(inputType.removeFirst())
        
        progress.send(Float(totalInputTypeCount - inputType.count) / Float(totalInputTypeCount))
    }
    
    @objc
    func showNextInputForm() {
        if inputType.isEmpty {
            navigation.send(.nextStep(currentLessonInformation: lessonInformation))
        } else {
            currentInputFormMeta.send(inputType.removeFirst())
            progress.send(Float(totalInputTypeCount - inputType.count) / Float(totalInputTypeCount))
        }
    }
    
    func keyboardWillAppear(with keyboardHeight: CGFloat, safeAreaBottomInset: CGFloat) {
        if nextButtonState.value.buttonConstraint.bottom != 0 {
            return
        }
        
        var prevState = nextButtonState.value
        prevState.buttonConstraint = .init(top: 0, left: 0, bottom: -(keyboardHeight - safeAreaBottomInset), right: 0)
        prevState.isRoundCorner = false
        
        nextButtonState.send(prevState)
    }
    
    func keyboardWillDisappear() {
        var prevState = nextButtonState.value
        
        prevState.buttonConstraint = layoutContainer.inset
        prevState.isRoundCorner = true
        
        nextButtonState.send(prevState)
    }
    
    func bindWithSelectStartDateView(_ state: AnyPublisher<SlothSelectDateInputFormViewModel.State, Never>) {
        state
            .map(\.tapped)
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.navigation.send(.startDatePicker(prevSelected: self?.selectedStartDate))
            }.store(in: &anyCancellables)
        
        state
            .map(\.dateDelivered)
            .dropFirst()
            .sink { [weak self] dateDelivered in
                guard let self = self else {
                    return
                }
                
                var prevState = self.nextButtonState.value
                
                prevState.isEnabled = dateDelivered
                
                self.nextButtonState.send(prevState)
            }.store(in: &anyCancellables)
    }
    
    func startDateDidSelected(_ startDate: AnyPublisher<Date, Never>) {
        startDate
            .sink { [weak self] date in
                self?.selectedStartDate = date
                self?.lessonInformation.startDate = date
            }.store(in: &anyCancellables)
    }
    
    func bindWithSelectEndDateView(_ state: AnyPublisher<SlothSelectDateInputFormViewModel.State, Never>) {
        
    }
    
    func bindWithPriceView(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
        
    }
    
    func bindWithDetermination(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
    }
}
