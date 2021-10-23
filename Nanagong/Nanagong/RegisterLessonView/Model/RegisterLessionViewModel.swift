//
//  RegisterLessionViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/21.
//

import Combine
import UIKit

enum InputType {
    
    case text
    
    case selectText
}

struct RegisterLessonMeta {
    
    let inputType: InputType
    let key: String
    let title: String
    let placeholder: String?
}

final class RegisterLessionViewModel {
    
    @Published var buttonConstraint: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    let currentInputFormMeta: PassthroughSubject<RegisterLessonMeta, Never> = .init()
    private var meta: [RegisterLessonMeta] = .init()
    
    private let layoutContainer: RegisterLessonViewLayoutContainer = .init()
    private let networkManager: NetworkManager
    private var currentLessonInputTypeIndex: Int = 0
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    var inset: UIEdgeInsets {
        return layoutContainer.inset
    }
    
    func keyboardWillAppear(with keyboardHeight: CGFloat, safeAreaBottomInset: CGFloat) {
        if buttonConstraint.bottom != 0 {
            return
        }
        
        buttonConstraint = .init(top: 0, left: 0, bottom: -(keyboardHeight - safeAreaBottomInset), right: 0)
    }
    
    func keyboardWillDisappear() {
        buttonConstraint = .init(top: 0, left: inset.left, bottom: 0, right: -inset.right)
    }
    
    func retrieveRegisterLessonForm() {
        meta = [
            .init(inputType: .text,
                  key: "text",
                  title: "강의 이름",
                  placeholder: "수강할 인강 이름을 입력하세요."),
            .init(inputType: .text,
                  key: "numberOfLessons",
                  title: "강의 개수",
                  placeholder: "전체 강의 개수를 입력하세요."),
            .init(inputType: .selectText,
                  key: "category",
                  title: "카테고리",
                  placeholder: "인강 카테고리를 선택하세요."),
            .init(inputType: .selectText,
                  key: "site",
                  title: "강의 사이트",
                  placeholder: "강의 사이트를 선택하세요.")
        ]
        
        currentInputFormMeta.send(meta[currentLessonInputTypeIndex])
    }
    
    @objc
    func showNextInputForm() {
        currentLessonInputTypeIndex += 1
        
        if currentLessonInputTypeIndex >= meta.count {
            currentInputFormMeta.send(completion: .finished)
        } else {
            currentInputFormMeta.send(meta[currentLessonInputTypeIndex])
        }
    }
}
