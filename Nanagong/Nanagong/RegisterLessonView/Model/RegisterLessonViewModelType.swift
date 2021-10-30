//
//  RegisterLessonViewModelType.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import Combine
import UIKit

protocol RegisterLessonViwModelType {
    
    var inset: UIEdgeInsets { get }
    var currentInputFormMeta: PassthroughSubject<SlothInputFormViewMeta, Never> { get }
    var nextButtonState: CurrentValueSubject<RegisterLessonNextButtonStateType, Never> { get }
    var progress: PassthroughSubject<Float, Never> { get }
    var navigation: PassthroughSubject<RegisterLessionViewNavigationType, Never> { get }
    
    func retrieveRegisterLessonForm()
    func showNextInputForm()
    func keyboardWillAppear(with: CGFloat, safeAreaBottomInset: CGFloat)
    func keyboardWillDisappear()
}
