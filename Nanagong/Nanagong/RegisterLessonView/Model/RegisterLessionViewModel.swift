//
//  RegisterLessionViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/21.
//

import Combine
import UIKit

final class RegisterLessionViewModel {
    
    @Published var buttonConstraint: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    
    private let layoutContainer: RegisterLessonViewLayoutContainer = .init()
    
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
    
    @objc
    func showNextInputForm() {
        print("tapped")
    }
}
