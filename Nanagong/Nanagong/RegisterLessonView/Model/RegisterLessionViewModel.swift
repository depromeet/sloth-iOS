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

enum RegisterLessionViewNavigationType {
    
    case none
    
    case categoryPicker(selected: IdNamePairType?)
    
    case sitePicker(selected: IdNamePairType?)
    
    case nextStep
}

final class RegisterLessionViewModel {
    
    @Published var nextButtonState: ButtonState
    @Published var progress: Float = 0
    
    @Published var selectedCategory: IdNamePairType?
    @Published var selectedSite: IdNamePairType?
    
    @Published var navigation: RegisterLessionViewNavigationType = .none
    
    let currentInputFormMeta: PassthroughSubject<SlothInputFormViewMeta, Never> = .init()
    private var inputType: [SlothInputFormViewMeta]
    private let layoutContainer: RegisterLessonViewLayoutContainer
    private let networkManager: NetworkManager
    private var totalInputTypeCount: Int
    private var lessonInformation: LessonInformation = .empty
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(inputType: [SlothInputFormViewMeta],
         networkManager: NetworkManager,
         layoutContainer: RegisterLessonViewLayoutContainer) {
        self.inputType = inputType
        self.totalInputTypeCount = inputType.count
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
        currentInputFormMeta.send(inputType.removeFirst())
        progress = Float(totalInputTypeCount - inputType.count) / Float(totalInputTypeCount)
    }
    
    @objc
    func showNextInputForm() {
        if inputType.isEmpty {
            navigation = .nextStep
        } else {
            currentInputFormMeta.send(inputType.removeFirst())
            progress = Float(totalInputTypeCount - inputType.count) / Float(totalInputTypeCount)
        }
    }
    
    func bindWithNameViewState(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
        bindWithButton(state
                        .map(\.isValid)
                        .removeDuplicates()
                        .eraseToAnyPublisher())
        
        state
            .map(\.input)
            .sink { input in
                guard let input = input else {
                    return
                }
                
                self.lessonInformation.lessonName = input
            }.store(in: &anyCancellables)
    }
    
    func bindWithNumberOfLessonsViewState(_ state: AnyPublisher<SlothTextFieldInputFormViewModel.State, Never>) {
        bindWithButton(state
                        .map(\.isValid)
                        .removeDuplicates()
                        .eraseToAnyPublisher())
        
        state
            .map(\.input)
            .sink { input in
                guard let input = input,
                      let total = Int(input) else {
                    return
                }
                
                self.lessonInformation.totalNumber = total
            }.store(in: &anyCancellables)
    }
    
    func bindWithCategorySelectViewState(_ state: AnyPublisher<SlothSelectBoxInputFormViewModel.State, Never>) {
        state
            .map(\.tapped)
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.navigation = .categoryPicker(selected: self?.selectedCategory)
            }.store(in: &anyCancellables)
        
        bindWithButton(state
                        .map(\.isValid)
                        .removeDuplicates()
                        .eraseToAnyPublisher())
        
        state
            .map(\.directionInput)
            .sink { [weak self] input in
                self?.lessonInformation.categoryName = input
            }.store(in: &anyCancellables)
    }
    
    func bindWithSiteSelectViewState(_ state: AnyPublisher<SlothSelectBoxInputFormViewModel.State, Never>) {
        state
            .map(\.tapped)
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.navigation = .sitePicker(selected: self?.selectedSite)
            }.store(in: &anyCancellables)
        
        bindWithButton(state
                        .map(\.isValid)
                        .removeDuplicates()
                        .eraseToAnyPublisher())
        
        state
            .map(\.directionInput)
            .sink { [weak self] input in
                self?.lessonInformation.siteName = input
            }.store(in: &anyCancellables)
    }
    
    func categoryDidSelected(_ category: AnyPublisher<IdNamePairType, Never>) {
        category
            .sink { [weak self] in
                self?.selectedCategory = $0
                self?.lessonInformation.categoryId = $0.id
            }.store(in: &anyCancellables)
    }
    
    func siteDidSelected(_ site: AnyPublisher<IdNamePairType, Never>) {
        site
            .sink { [weak self] in
                self?.selectedSite = $0
                self?.lessonInformation.siteId = $0.id
            }.store(in: &anyCancellables)
    }
    
    private func bindWithButton(_ state: AnyPublisher<Bool, Never>) {
        state
            .sink { [weak self] isValid in
                self?.nextButtonState.isEnabled = isValid
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
