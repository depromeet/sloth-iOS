//
//  RegisterLessonViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/20.
//

import UIKit
import SlothDesignSystemModule

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
    
    private let layoutContainer: RegisterLessonViewLayoutContainer = .init()
    private var nextButtonleadingConstraint: NSLayoutConstraint!
    private var nextButtonTrailingConstraint: NSLayoutConstraint!
    private var nextButtonBottomConstraint: NSLayoutConstraint!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setUpSubviews()
        addObservers()
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
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutContainer.inset.left),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutContainer.inset.right),
            titleLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 98)
        ])
    }
    
    private func setUpNextButton() {
        view.addSubview(nextButton)
        
        nextButton.setTitle("다음")
        
        nextButtonleadingConstraint = nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutContainer.inset.left)
        nextButtonTrailingConstraint = nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutContainer.inset.right)
        nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            nextButtonleadingConstraint,
            nextButtonTrailingConstraint,
            nextButtonBottomConstraint
        ])
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        if nextButtonBottomConstraint.constant == 0 {
            nextButtonBottomConstraint.constant -= (keyboard.height - view.safeAreaInsets.bottom)
            nextButtonleadingConstraint.constant = 0
            nextButtonTrailingConstraint.constant = 0
            nextButton.toggleCornerRadius()
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        nextButtonBottomConstraint.constant += (keyboard.height - view.safeAreaInsets.bottom)
        nextButtonleadingConstraint.constant = layoutContainer.inset.left
        nextButtonTrailingConstraint.constant = -layoutContainer.inset.right
        nextButton.toggleCornerRadius()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
