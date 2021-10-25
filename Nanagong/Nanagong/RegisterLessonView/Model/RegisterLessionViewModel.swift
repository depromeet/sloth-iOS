//
//  RegisterLessionViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/21.
//

import Combine
import UIKit

enum InputType {
    
    enum Text {
        
        case name
        
        case numberOfLessons
        
        var viewMeta: SlothInputFormViewMeta {
            switch self {
            case .name:
                return .init(title: "강의 이름",
                             placeholder: "수강할 인강 이름을 입력하세요.")
                
            case .numberOfLessons:
                return .init(title: "강의 개수",
                             placeholder: "전체 강의 개수를 입력하세요.")
            }
        }
    }
    
    enum SelectBox {
        
        case cateogry
        
        case site
        
        var viewMeta: SlothInputFormViewMeta {
            switch self {
            case .cateogry:
                return .init(title: "카테고리",
                             placeholder: "인강 카테고리를 선택하세요.")
                
            case .site:
                return .init(title: "강의 사이트",
                             placeholder: "강의 사이트를 선택하세요.")
            }
        }
    }
    
    case text(Text)
    
    case selectBox(SelectBox)
        
    var key: String {
        switch self {
        case .text(let text):
            switch text {
            case .name:
                return "name"
            case .numberOfLessons:
                return "numberOfLessons"
            }
            
        case .selectBox(let selectBox):
            switch selectBox {
            case .cateogry:
                return "category"
                
            case .site:
                return "site"
            }
        }
    }
}

struct SlothInputFormViewMeta {
   
    let title: String
    let placeholder: String?
}

final class RegisterLessionViewModel {
    
    @Published var buttonConstraint: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    @Published var progress: Float = 0
    let currentInputFormMeta: PassthroughSubject<InputType, Never> = .init()
    private var inputType: [InputType] = [.text(.name), .text(.numberOfLessons), .selectBox(.cateogry), .selectBox(.site)]
    
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
}
