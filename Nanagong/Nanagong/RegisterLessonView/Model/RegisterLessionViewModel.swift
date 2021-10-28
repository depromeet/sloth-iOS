//
//  RegisterLessionViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/21.
//

import Combine
import UIKit

enum InputFormType {
    
    case lessonName
    
    case numberOfLessons
    
    case lessonCategory
    
    case lessonSite
}

struct SlothInputFormViewMeta {
    
    let inputFormType: InputFormType
    let title: String
    let placeholder: String?
}

final class RegisterLessionViewModel {
    
    @Published var nextButtonState: ButtonState
    @Published var progress: Float = 0
    
    let currentInputFormMeta: PassthroughSubject<SlothInputFormViewMeta, Never> = .init()
    private let inputType: [SlothInputFormViewMeta]
    private let layoutContainer: RegisterLessonViewLayoutContainer
    private let networkManager: NetworkManager
    private var currentLessonInputTypeIndex: Int = 0
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(inputType: [SlothInputFormViewMeta],
         networkManager: NetworkManager,
         layoutContainer: RegisterLessonViewLayoutContainer) {
        self.inputType = inputType
        self.networkManager = networkManager
        self.layoutContainer = layoutContainer
        self.nextButtonState = .init(buttonConstraint: layoutContainer.inset,
                                     isEnabled: false,
                                     isRoundCorner: true)
    }
    
    var inset: UIEdgeInsets {
        return layoutContainer.inset
    }
    
    func keyboardWillAppear(with keyboardHeight: CGFloat, safeAreaBottomInset: CGFloat) {
        if nextButtonState.buttonConstraint.bottom != 0 {
            return
        }
        
        nextButtonState.buttonConstraint = .init(top: 0, left: 0, bottom: -(keyboardHeight - safeAreaBottomInset), right: 0)
        nextButtonState.isRoundCorner = false
    }
    
    func keyboardWillDisappear() {
        nextButtonState.buttonConstraint = layoutContainer.inset
        nextButtonState.isRoundCorner = true
    }
    
    func retrieveRegisterLessonForm() {
        currentInputFormMeta.send(inputType[currentLessonInputTypeIndex])
        progress = Float(currentLessonInputTypeIndex) / Float(inputType.count)
    }
    
    @objc
    func showNextInputForm() {
        currentLessonInputTypeIndex += 1
        
        if currentLessonInputTypeIndex >= inputType.count {
            currentInputFormMeta.send(completion: .finished)
        } else {
            currentInputFormMeta.send(inputType[currentLessonInputTypeIndex])
            progress = Float(currentLessonInputTypeIndex) / Float(inputType.count)
        }
    }
    
    func bindWithNameValidator(_ validation: AnyPublisher<Bool, Never>) {
        validation
            .sink { [weak self] bool in
                self?.nextButtonState.isEnabled = bool
            }.store(in: &anyCancellables)
    }
    
    func bindWithNumberOfLessonsValidator(_ validation: AnyPublisher<Bool, Never>) {
        validation
            .sink { [weak self] bool in
                self?.nextButtonState.isEnabled = bool
            }.store(in: &anyCancellables)
    }
    
    func cateogrySelectBoxTapped(_ event: AnyPublisher<Void, Never>) {
        event
            .sink { _ in
                print("cate")
            }.store(in: &anyCancellables)
    }
    
    func siteSelecBoxTapped(_ event: AnyPublisher<Void, Never>) {
        event
            .sink { _ in
                print("site")
            }.store(in: &anyCancellables)
    }
}

extension RegisterLessionViewModel {
    
    struct ButtonState {

        var buttonConstraint: UIEdgeInsets
        var isEnabled: Bool
        var isRoundCorner: Bool
    }
}
