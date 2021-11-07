//
//  RegisterLessionInformationViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/21.
//

import Combine
import UIKit

struct SlothInputFormViewMeta {
    
    let inputFormType: RegisterInputFormType
    let title: String
    let placeholder: String?
}

final class RegisterLessionInformationViewModel: RegisterLessonViwModelType {
        
    @Published var selectedCategory: IdNamePairType?
    @Published var selectedSite: IdNamePairType?
    
    let title: String = "어떤 강의를 들으시나요?"
    let nextButtonState: CurrentValueSubject<RegisterLessonNextButtonState, Never>
    let currentInputFormMeta: PassthroughSubject<SlothInputFormViewMeta, Never> = .init()
    let progress: PassthroughSubject<Float, Never> = .init()
    let navigation: PassthroughSubject<RegisterLessionViewNavigationType, Never> = .init()
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
        self.nextButtonState = .init(
            .init(title: "다음",
                  buttonConstraint: layoutContainer.inset,
                  isEnabled: false,
                  isRoundCorner: true)
        )
    }
    
    var inset: UIEdgeInsets {
        return layoutContainer.inset
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
                self?.navigation.send(.categoryPicker(selected: self?.selectedCategory))
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
                self?.navigation.send(.sitePicker(selected: self?.selectedSite))
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
                guard let self = self else {
                    return
                }
                
                var prevState = self.nextButtonState.value
                prevState.isEnabled = isValid
                
                self.nextButtonState.send(prevState)
            }.store(in: &anyCancellables)
    }
}
