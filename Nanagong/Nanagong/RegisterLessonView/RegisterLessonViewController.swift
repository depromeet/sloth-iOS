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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "새로운 인강 등록"
        setUpProgressView()
        setUpTitleLabel()
        setUpNextButton()
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
        
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutContainer.inset.left),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutContainer.inset.right),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
