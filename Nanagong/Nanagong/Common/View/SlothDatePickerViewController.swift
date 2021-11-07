//
//  SlothDatePickerViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/06.
//

import Combine
import SlothDesignSystemModule
import UIKit

final class SlothDatePickerViewController: UIViewController {
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    
    private let confirmButton: SlothButton = {
        let button = SlothButton(buttonStyle: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인")
        button.changeCornerToRound()
        
        return button
    }()
    
    private let viewModel: SlothDatePickerViewModel
    private let layoutContainer: SlothDatePickerViewLayoutContainer
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(viewModel: SlothDatePickerViewModel) {
        self.viewModel = viewModel
        self.layoutContainer = .init()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUpSubviews()
        bind()
    }
    
    private func setUpSubviews() {
        setUpDatePicker()
        setUpConfirmButton()
    }
    
    private func setUpDatePicker() {
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutContainer.datePicker.inset.left),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutContainer.datePicker.inset.right),
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: layoutContainer.datePicker.inset.top),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        datePicker.preferredDatePickerStyle = layoutContainer.datePicker.preferredDatePickerStyle
        datePicker.datePickerMode = layoutContainer.datePicker.datePickerMode
        datePicker.tintColor = layoutContainer.datePicker.tintColor
        
        datePicker.date = viewModel.prevSelectedDate ?? .now
        
        if let startDate = viewModel.startDate {
            datePicker.minimumDate = startDate
        }
        
        datePicker.addTarget(viewModel, action: #selector(viewModel.dateSelected(_:)), for: .valueChanged)
    }
    
    private func setUpConfirmButton() {
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutContainer.confirmButton.inset.left),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutContainer.confirmButton.inset.right),
            confirmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: layoutContainer.confirmButton.inset.top),
            confirmButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -layoutContainer.confirmButton.inset.bottom)
        ])
        
        confirmButton.addTarget(viewModel, action: #selector(viewModel.confirmButtonTapped), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.decidedDate
            .sink { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }.store(in: &anyCancellables)
    }
}

extension SlothDatePickerViewController: DimPresentationControllerDelegate {
    
    func frameOfPresentedViewInContainerView(frame: CGRect) -> CGRect {
        let height = datePicker.bounds.height + confirmButton.bounds.height + layoutContainer.heightOfMargins
        
        return .init(origin: .init(x: 0, y: frame.height - height),
                     size: .init(width: frame.width, height: height))
    }
}

extension SlothDatePickerViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimPresentationController(presentaionDelegate: self,
                                         presentedViewController: presented,
                                         presenting: presenting)
    }
}
