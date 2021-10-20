//
//  SlothInputFormView.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/20.
//

import UIKit
import SlothDesignSystemModule

final class SlothInputFormView: UIView {
    
    enum InputType {
        
        case textField
        
        case button
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "타이틀"
        return label
    }()
    
    private lazy var textField: SlothTextField = {
        let textField = SlothTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "플레이스홀더"
        return textField
    }()
    
    private let inputType: InputType
    
    init(inputType: InputType) {
        self.inputType = inputType
        
        super.init(frame: .zero)
        
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        setUpTitleLabel()
        setUpInputForm()
    }
    
    private func setUpTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func setUpInputForm() {
        switch inputType {
        case .textField:
            setUpView(textField)
            
        case .button:
            break
        }
        
        func setUpView(_ view: UIView) {
            addSubview(view)
            
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}