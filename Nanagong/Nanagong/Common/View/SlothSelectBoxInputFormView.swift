//
//  SlothSelectBoxInputFormView.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/26.
//

import Combine
import SlothDesignSystemModule
import UIKit

final class SlothSelectBoxInputFormView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "타이틀"
        return label
    }()
    
    private let inputFormContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()

    private let selectBox: SlothSelectBox = {
        let selectBox = SlothSelectBox()
        selectBox.translatesAutoresizingMaskIntoConstraints = false

        return selectBox
    }()
    
    private let textField: SlothTextField = {
        let textField = SlothTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()

    private let viewModel: SlothSelectBoxInputFormViewModel
    private var anyCancellable: Set<AnyCancellable> = .init()

    init(viewModel: SlothSelectBoxInputFormViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setUpSubviews()
        setUpAttributes()
        viewModel.inputSelected
            .compactMap { $0 }
            .map(\.name)
            .sink(receiveValue: { [weak self] text in
                self?.selectBox.text = text
            })
            .store(in: &anyCancellable)
        
        viewModel.$needsShowTextField
            .removeDuplicates()
            .sink { [weak self] in
                if $0 {
                    self?.textField.text = nil
                    self?.textField.slothAnimator.fadeIn()
                } else {
                    self?.textField.slothAnimator.fadeOut()
                }
            }.store(in: &anyCancellable)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpSubviews() {
        setUpTitleLabel()
        setUpInputFormStackView()
    }

    private func setUpTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func setUpInputFormStackView() {
        addSubview(inputFormContainerStackView)
        
        NSLayoutConstraint.activate([
            inputFormContainerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputFormContainerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputFormContainerStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            inputFormContainerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setUpSelectBox()
        setUpTextField()
    }
    
    private func setUpSelectBox() {
        inputFormContainerStackView.addArrangedSubview(selectBox)
        
        selectBox.addTarget(self, action: #selector(selectBoxTapped), for: .touchUpInside)
    }
    
    private func setUpTextField() {
        inputFormContainerStackView.addArrangedSubview(textField)
        textField.isHidden = true
        textField.delegate = self
    }
    
    private func setUpAttributes() {
        titleLabel.text = viewModel.title
        selectBox.placeholder = viewModel.placeholder
    }
    
    @objc func selectBoxTapped() {
        viewModel.tapped.send()
    }
}

extension SlothSelectBoxInputFormView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.textFieldInput.send(textField.text)
    }
}
