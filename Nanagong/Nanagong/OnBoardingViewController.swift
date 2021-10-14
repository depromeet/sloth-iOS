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
    
    private let createUserSessionButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.onboardingViewModel.signInWithKakao()
                .sink { result in
                    print(result)
                } receiveValue: { token in
                    print(token)
                }.store(in: &self.anyCancellables)
        }))
        
        button.setBackgroundImage(UIImage(named: "kakao_login_large_wide"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .wide
        button.addTarget(self, action: #selector(tapGoogleLoginButton), for: .touchUpInside)
      
        return button
    }()

    private lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
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
        
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        setUpLoginButtonStackView()
    }
    
    private func setUpLoginButtonStackView() {
        view.addSubview(createUserSessionButtonStackView)
        
        NSLayoutConstraint.activate([
            createUserSessionButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createUserSessionButtonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        setUpKakaoLoginButton()
        setUpGoogleLoignButton()
        setUpAppleLoginButton()
    }
    
    private func setUpKakaoLoginButton() {
        createUserSessionButtonStackView.addArrangedSubview(kakaoLoginButton)
        
        NSLayoutConstraint.activate([
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 50),
            kakaoLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setUpGoogleLoignButton() {
        createUserSessionButtonStackView.addArrangedSubview(googleLoginButton)
        
        NSLayoutConstraint.activate([
            googleLoginButton.heightAnchor.constraint(equalToConstant: 50),
            googleLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
  
    private func setUpAppleLoginButton() {
        createUserSessionButtonStackView.addArrangedSubview(appleLoginButton)
        appleLoginButton.addTarget(self, action: #selector(loginWithApple), for: .touchUpInside)
    }
    
    @objc 
    private func tapGoogleLoginButton() {
        onboardingViewModel.signInWithGoogle(presentViewController: self)
            .sink { result in
                print(result)
            } receiveValue: { idToken in
                print(idToken)
            }.store(in: &self.anyCancellables)
    }
    
    @objc
    private func loginWithApple() {
        onboardingViewModel.signInWithApple()
            .sink { result in
                print(result)
            } receiveValue: { credential in
                print(credential)
            }.store(in: &anyCancellables)
    }
}
