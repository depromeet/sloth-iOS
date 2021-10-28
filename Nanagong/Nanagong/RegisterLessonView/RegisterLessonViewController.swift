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
    
    private let viewModel: RegisterLessionViewModel
    private let registerLessonInputFormViewFactory: RegisterLessonInputFormViewFactory
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    init(viewModel: RegisterLessionViewModel,
         registerLessonInputFormViewFactory: RegisterLessonInputFormViewFactory) {
        self.viewModel = viewModel
        self.registerLessonInputFormViewFactory = registerLessonInputFormViewFactory
        
        super.init(nibName: nil, bundle: nil)
        
        setUpSubviews()
        addObservers()
        bind()
        viewModel.retrieveRegisterLessonForm()
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

        setUpNextButton()
        setUpInputFormScrollView()
        setUpTitleLabel()
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
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setUpTitleLabel() {
        inputFormStackView.addArrangedSubview(titleLabel)
        
        titleLabel.text = "완강 목표를 설정해 보세요!"
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 98)
        ])
    }
    
    private func setUpNextButton() {
        view.addSubview(nextButton)
        
        nextButton.setTitle("다음")
        nextButton.addTarget(viewModel, action: #selector(viewModel.showNextInputForm), for: .touchUpInside)
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
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButton.topAnchor),
            inputFormStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: viewModel.inset.left),
            inputFormStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -viewModel.inset.right),
            inputFormStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            inputFormStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
    
    private func bind() {
        bindWithLessonFormScrollView()
        bindWithNextButton()
        bindWithProgressView()
    }
    
    private func bindWithLessonFormScrollView() {
        viewModel.currentInputFormMeta
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                
                let inputFormView = self.registerLessonInputFormViewFactory.makeInputFormView(with: $0)

                inputFormView.alpha = 0
                inputFormView.isHidden = true
                
                UIViewPropertyAnimator(duration: 0.3,
                                       curve: .easeOut) { [weak self] in
                    self?.inputFormStackView.insertArrangedSubview(inputFormView, at: 1)
                    inputFormView.alpha = 1
                    inputFormView.isHidden = false
                }.startAnimation()
            }.store(in: &anyCancellable)
    }
    
    private func bindWithNextButton() {
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
    
    private func bindWithProgressView() {
        viewModel.$progress
            .sink(receiveValue: { [weak self] progress in
                self?.progressView.setProgress(progress, animated: true)
            })
            .store(in: &anyCancellable)
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
