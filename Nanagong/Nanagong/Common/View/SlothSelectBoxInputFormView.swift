//
//  SlothSelectBoxInputFormView.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/26.
//

import SlothDesignSystemModule
import UIKit

final class SlothSelectBoxInputFormView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "타이틀"
        return label
    }()

    private lazy var selectBox: SlothSelectBox = {
        let selectBox = SlothSelectBox()
        selectBox.translatesAutoresizingMaskIntoConstraints = false

        return selectBox
    }()

    private let viewModel: SlothSelectBoxInputFormViewModel

    init(viewModel: SlothSelectBoxInputFormViewModel) {
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
        addSubview(selectBox)
        
        NSLayoutConstraint.activate([
            selectBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectBox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            selectBox.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        selectBox.addTarget(self, action: #selector(selectBoxTapped), for: .touchUpInside)
    }
    
    private func setUpAttributes() {
        titleLabel.text = viewModel.title
        selectBox.placeholder = viewModel.placeholder
    }
    
    @objc func selectBoxTapped() {
        viewModel.tapped.send()
    }
}
