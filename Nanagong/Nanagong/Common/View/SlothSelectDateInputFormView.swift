//
//  SlothSelectDateInputFormView.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/06.
//

import Combine
import SlothDesignSystemModule
import UIKit

final class SlothSelectDateInputFormView: UIView {

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

    private let viewModel: SlothSelectDateInputFormViewModel
    private var anyCancellable: Set<AnyCancellable> = .init()

    init(viewModel: SlothSelectDateInputFormViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setUpSubviews()
        setUpAttributes()
        viewModel.dateSelected
            .sink(receiveValue: { [weak self] date in
                self?.selectBox.text = date.toString()
            })
            .store(in: &anyCancellable)
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
    }
    
    private func setUpSelectBox() {
        inputFormContainerStackView.addArrangedSubview(selectBox)
        
        selectBox.addTarget(self, action: #selector(selectBoxTapped), for: .touchUpInside)
    }
    
    private func setUpAttributes() {
        titleLabel.text = viewModel.title
        selectBox.placeholder = viewModel.placeholder
    }
    
    @objc func selectBoxTapped() {
        viewModel.selectBoxTapped()
    }
}
