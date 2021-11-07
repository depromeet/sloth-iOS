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
    
    struct InputFormValitator {
        
        var isStartDateValid: Bool = true
        var isEndDateValid: Bool = true
        var isPriceValid: Bool = true
        var isDeterminationValid: Bool = true
        
        var isValid: Bool {
            return isStartDateValid && isEndDateValid && isPriceValid && isDeterminationValid
        }
    }
    
    @Published var selectedStartDate: Date = .init()
    @Published var selectedEndDate: Date = .init()
    
    var inset: UIEdgeInsets {
        return layoutContainer.inset
    }
    let title: String = "완강 목표를 설정해 보세요!"
    let currentInputFormMeta: PassthroughSubject<SlothInputFormViewMeta, Never> = .init()
    let nextButtonState: CurrentValueSubject<RegisterLessonNextButtonState, Never>
    let progress: PassthroughSubject<Float, Never> = .init()
    let navigation: PassthroughSubject<RegisterLessionViewNavigationType, Never> = .init()
    
    private var inputType: [SlothInputFormViewMeta]
    private let networkManager: NetworkManager
    private let layoutContainer: RegisterLessonViewLayoutContainer
    private var totalInputTypeCount: Int
    private var lessonInformation: LessonInformation
    private var inputFormValidator: InputFormValitator = .init()
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
            .init(title: "다음",
                  buttonConstraint: layoutContainer.inset,
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
        var prevState = nextButtonState.value
        prevState.isEnabled = false
        nextButtonState.send(prevState)
        
        if inputType.isEmpty {
            navigation.send(.nextStep(currentLessonInformation: lessonInformation))
        } else {
            if inputType.count == 1 {
                var prevState = nextButtonState.value
                prevState.title = "완료"
                
                nextButtonState.send(prevState)
            }
            
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
                
                self.inputFormValidator.isStartDateValid = dateDelivered
                var prevState = self.nextButtonState.value
                prevState.isEnabled = self.inputFormValidator.isValid
                
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
        state
            .map(\.tapped)
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.navigation.send(.endDatePicker(prevSelected: self?.selectedEndDate))
            }.store(in: &anyCancellables)
        
        state
            .map(\.dateDelivered)
            .dropFirst()
            .sink { [weak self] dateDelivered in
                guard let self = self else {
                    return
                }
                
                self.inputFormValidator.isEndDateValid = dateDelivered
                var prevState = self.nextButtonState.value
                prevState.isEnabled = self.inputFormValidator.isValid
                
                self.nextButtonState.send(prevState)
            }.store(in: &anyCancellables)
    }
    
    func endDateDidSelected(_ endDate: AnyPublisher<Date, Never>) {
        endDate
            .sink { [weak self] date in
                self?.selectedEndDate = date
                self?.lessonInformation.endDate = date
            }.store(in: &anyCancellables)
    }
    
    func bindWithPriceView(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
        state
            .map(\.isValid)
            .sink { [weak self] isValid in
                guard let self = self else {
                    return
                }
                
                self.inputFormValidator.isPriceValid = isValid
                var prevState = self.nextButtonState.value
                prevState.isEnabled = self.inputFormValidator.isValid
                
                self.nextButtonState.send(prevState)
            }.store(in: &anyCancellables)
        
        state
            .map(\.input)
            .sink { input in
                guard let input = input,
                      let price = Int(input) else {
                    return
                }
                
                self.lessonInformation.price = price
            }.store(in: &anyCancellables)
    }
    
    func bindWithDetermination(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
        state
            .map(\.isValid)
            .sink { [weak self] isValid in
                guard let self = self else {
                    return
                }
                
                self.inputFormValidator.isDeterminationValid = isValid
                var prevState = self.nextButtonState.value
                prevState.isEnabled = self.inputFormValidator.isValid
                
                self.nextButtonState.send(prevState)
            }.store(in: &anyCancellables)
        
        state
            .map(\.input)
            .sink { [weak self] input in
                
                self?.lessonInformation.message = input
            }.store(in: &anyCancellables)
    }
}
