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
    
    init(inputType: [SlothInputFormViewMeta],
         networkManager: NetworkManager,
         layoutContainer: RegisterLessonViewLayoutContainer) {
        self.inputType = inputType
        self.networkManager = networkManager
        self.layoutContainer = layoutContainer
        self.nextButtonState = .init(
            .init(buttonConstraint: layoutContainer.inset,
                  isEnabled: false,
                  isRoundCorner: true)
        )
    }
    
    
    func retrieveRegisterLessonForm() {
        
    }
    
    func showNextInputForm() {
        
    }
    
    func keyboardWillAppear(with: CGFloat, safeAreaBottomInset: CGFloat) {
        
    }
    
    func keyboardWillDisappear() {
        
    }
}
