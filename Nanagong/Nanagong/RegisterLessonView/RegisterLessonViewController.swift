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
}
