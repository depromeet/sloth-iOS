//
//  SlothTextFieldInputFormView.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/20.
//

import UIKit
import SlothDesignSystemModule

final class SlothTextFieldInputFormView: UIView {
        
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
    
    private let viewModel: SlothTextFieldInputFormViewModel
    
    init(viewModel: SlothTextFieldInputFormViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        setUpTitleLabel()
        setUpInputForm()
        setUpAttributes()
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
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpAttributes() {
        titleLabel.text = viewModel.title
        textField.placeholder = viewModel.placeholder
    }
}
