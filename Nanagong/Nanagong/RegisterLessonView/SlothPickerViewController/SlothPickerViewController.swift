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
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        
        return indicator
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
        setUpIndicator()
        setUpPickerView()
        setUpConfirmButton()
    }
    
    private func setUpIndicator() {
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -layoutContainer.buttonHeight)
        ])
        
        indicator.startAnimating()
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
        
        pickerView.isHidden = true
    }
    
    private func setUpConfirmButton() {
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutContainer.buttonMargin.left),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutContainer.buttonMargin.right),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -layoutContainer.buttonMargin.bottom)
        ])
        
        confirmButton.addTarget(viewModel, action: #selector(viewModel.confirmButtonTapped), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.$list
            .dropFirst()
            .receive(on: DispatchQueue.global())
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.pickerView.slothAnimator.fadeIn()
                    self.indicator.stopAnimating()
                }
                
                DispatchQueue.main.sync {
                    self.pickerView.reloadComponent(0)
                    self.pickerView.selectRow(self.viewModel.currentIndex, inComponent: 0, animated: true)
                }
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
