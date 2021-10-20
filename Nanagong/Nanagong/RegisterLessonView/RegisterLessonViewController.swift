//
//  RegisterLessonViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/20.
//

import Combine
import SlothDesignSystemModule
import UIKit

final class RegisterLessonViewController: UIViewController {
    
    private let progressView: SlothProgressView = {
        let progressView = SlothProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
    
        return label
    }()
    
    private let nextButton: SlothButton = {
        let button = SlothButton(buttonStyle: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let inputFormStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 32
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private var nextButtonleadingConstraint: NSLayoutConstraint!
    private var nextButtonTrailingConstraint: NSLayoutConstraint!
    private var nextButtonBottomConstraint: NSLayoutConstraint!
    
    private let viewModel: RegisterLessionViewModel = .init()
    private var anyCancellable: Set<AnyCancellable> = .init()
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setUpSubviews()
        addObservers()
        bindWithNextButtonConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "새로운 인강 등록"
        setUpProgressView()
        setUpTitleLabel()
        setUpNextButton()
        setUpInputFormScrollView()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setUpProgressView() {
        view.addSubview(progressView)
        
        progressView.progress = 0.5
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "완강 목표를 설정해 보세요!"
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.inset.left),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.inset.right),
            titleLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 98)
        ])
    }
    
    private func setUpNextButton() {
        view.addSubview(nextButton)
        
        nextButton.setTitle("다음")
        nextButtonleadingConstraint = nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.inset.left)
        nextButtonTrailingConstraint = nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.inset.right)
        nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            nextButtonleadingConstraint,
            nextButtonTrailingConstraint,
            nextButtonBottomConstraint
        ])
    }
    
    private func setUpInputFormScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(inputFormStackView)
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped)))
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButton.topAnchor),
            inputFormStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: layoutContainer.inset.left),
            inputFormStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -layoutContainer.inset.right),
            inputFormStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            inputFormStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    
    private func bindWithNextButtonConstraint() {
        viewModel.$buttonConstraint
            .dropFirst()
            .sink { [weak self] constraints in
                self?.nextButtonBottomConstraint.constant = constraints.bottom
                self?.nextButtonleadingConstraint.constant = constraints.left
                self?.nextButtonTrailingConstraint.constant = constraints.right
                self?.nextButton.toggleCornerRadius()
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            }.store(in: &anyCancellable)
    }
    
    @objc func scrollViewTapped() {
        view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        viewModel.keyboardWillAppear(with: keyboard.height, safeAreaBottomInset: view.safeAreaInsets.bottom)
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        viewModel.keyboardWillDisappear()
    }
}
