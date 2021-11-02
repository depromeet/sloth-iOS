//
//  SlothTextFieldInputFormView.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/20.
//

import UIKit
import SlothDesignSystemModule

final class SlothTextFieldInputFormView: UIView {
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var textField: SlothTextField = {
        let textField = SlothTextField()
        
        return textField
    }()
    
    private let viewModel: SlothTextFieldInputFormViewModel
    
    init(viewModel: SlothTextFieldInputFormViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setUpSubviews()
        setUpAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }
    
    private func setUpSubviews() {
        setUpContainerStackView()
    }
    
    private func setUpContainerStackView() {
        addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setUpTitleLabel()
        setUpInputForm()
    }
    
    private func setUpTitleLabel() {
        containerStackView.addArrangedSubview(titleLabel)
    }
    
    private func setUpInputForm() {
        containerStackView.addArrangedSubview(textField)
        textField.delegate = self
    }
    
    private func setUpAttributes() {
        titleLabel.text = viewModel.title
        textField.placeholder = viewModel.placeholder
    }
}

extension SlothTextFieldInputFormView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.input.send(textField.text)
    }
}
