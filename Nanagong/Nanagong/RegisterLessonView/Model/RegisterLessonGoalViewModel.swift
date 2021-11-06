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
        
    }
    
    func bindWithSelectEndDateView(_ state: AnyPublisher<SlothSelectDateInputFormViewModel.State, Never>) {
        
    }
    
    func bindWithPriceView(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
        
    }
    
    func bindWithDetermination(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
    }
}
