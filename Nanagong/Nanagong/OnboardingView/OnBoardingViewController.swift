//
//  OnBoardingViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/04.
//

import AuthenticationServices
import Combine
import GoogleSignIn
import UIKit

final class OnBoardingViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .primarySlothFont(ofSize: 18)
        label.textColor = .Sloth.gray600
        label.text = "로그인 방법 선택"
        
        return label
    }()
    
    private let signInButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var kakaoSignInButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.onboardingViewModel.signInWithKakao()
                .sink { result in
                    print(result)
                } receiveValue: { signInResponse in
                    print(signInResponse)
                }.store(in: &self.anyCancellables)
        }))
        
        button.setBackgroundImage(UIImage(named: "kakao_login"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var googleSignInButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.onboardingViewModel.signInWithGoogle(presentViewController: self)
                .sink { result in
                    print(result)
                } receiveValue: { signInResponse in
                    print(signInResponse)
                }.store(in: &self.anyCancellables)
        }))
        
        button.setBackgroundImage(UIImage(named: "google_login"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // 키체인으로 저장하고~
    //
    private lazy var appleSignInButton: UIButton = {
        let button =  UIButton(primaryAction: UIAction(handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.onboardingViewModel.signInWithApple()
                .sink { result in
                    print(result)
                } receiveValue: { credential in
                    print(credential)
                }.store(in: &self.anyCancellables)
        }))
        
        button.setBackgroundImage(UIImage(named: "apple_login"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let onboardingViewModel: OnboardingViewModel
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        setUpTitleLabel()
        setUpSignInButtonStackView()
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpSignInButtonStackView() {
        view.addSubview(signInButtonStackView)
        
        NSLayoutConstraint.activate([
            signInButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            signInButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            signInButtonStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
        ])
        
        setUpGoogleSignInButton()
        setUpKakaoSignInButton()
        setUpAppleSignInButton()
    }
    
    private func setUpKakaoSignInButton() {
        signInButtonStackView.addArrangedSubview(kakaoSignInButton)
        
        NSLayoutConstraint.activate([
            kakaoSignInButton.heightAnchor.constraint(equalToConstant: 44),
            kakaoSignInButton.widthAnchor.constraint(equalTo: signInButtonStackView.widthAnchor)
        ])
    }
    
    private func setUpGoogleSignInButton() {
        signInButtonStackView.addArrangedSubview(googleSignInButton)
        
        NSLayoutConstraint.activate([
            googleSignInButton.heightAnchor.constraint(equalToConstant: 44),
            googleSignInButton.widthAnchor.constraint(equalTo: signInButtonStackView.widthAnchor)
        ])
    }
    
    private func setUpAppleSignInButton() {
        signInButtonStackView.addArrangedSubview(appleSignInButton)
        
        NSLayoutConstraint.activate([
            appleSignInButton.heightAnchor.constraint(equalToConstant: 44),
            appleSignInButton.widthAnchor.constraint(equalTo: signInButtonStackView.widthAnchor)
        ])
    }
}
