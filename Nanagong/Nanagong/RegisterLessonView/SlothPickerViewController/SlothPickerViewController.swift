//
//  SlothPickerViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import Combine
import SlothDesignSystemModule
import UIKit

final class SlothPickerViewController: UIViewController {
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private let confirmButton: SlothButton = {
        let button = SlothButton(buttonStyle: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인")
        
        return button
    }()
    
    private let viewModel: SlothPickerViewModel
    private let layoutContainer: SlothPickerViewLayoutContainer
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(viewModel: SlothPickerViewModel,
         layoutContainer: SlothPickerViewLayoutContainer) {
        self.viewModel = viewModel
        self.layoutContainer = layoutContainer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Sloth.white
        
        setUpSubviews()
        bind()
        
        viewModel.retrieveList()
    }
    
    private func setUpSubviews() {
        setUpPickerView()
        setUpConfirmButton()
    }
    
    private func setUpPickerView() {
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: layoutContainer.pickerMargin.top),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: layoutContainer.pickerHeight)
        ])
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setUpConfirmButton() {
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: layoutContainer.buttonMargin.top),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutContainer.buttonMargin.left),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutContainer.buttonMargin.right),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -layoutContainer.buttonMargin.bottom)
        ])
        
        confirmButton.addTarget(viewModel, action: #selector(viewModel.confirmButtonTapped), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.$list
            .sink { _ in
                self.pickerView.reloadAllComponents()
            }.store(in: &anyCancellables)
        
        viewModel.selectedItem
            .sink { [weak self] _ in
                self?.dismiss(animated: true)
            }.store(in: &anyCancellables)
    }
}

extension SlothPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.list[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.currentIndex = row
    }
}

extension SlothPickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.list.count
    }
}

extension SlothPickerViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimPresentationController(presentaionDelegate: self, presentedViewController: presented, presenting: presenting)
    }
}

extension SlothPickerViewController: DimPresentationControllerDelegate {
    
    func frameOfPresentedViewInContainerView(frame: CGRect) -> CGRect {
        return .init(origin: .init(x: 0, y: frame.height - layoutContainer.totalHeight),
                     size: .init(width: frame.width, height: layoutContainer.totalHeight))
    }
}
