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
    
    private let signInButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
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
                } receiveValue: { token in
                    print(token)
                }.store(in: &self.anyCancellables)
        }))
        
        button.setBackgroundImage(UIImage(named: "kakao_login_large_wide"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var googleSignInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .wide
        button.addTarget(self, action: #selector(tapGoogleSignInButton), for: .touchUpInside)
      
        return button
    }()

    private lazy var appleSignInButton: ASAuthorizationAppleIDButton = {
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
        setUpSignInButtonStackView()
    }
    
    private func setUpSignInButtonStackView() {
        view.addSubview(signInButtonStackView)
        
        NSLayoutConstraint.activate([
            signInButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButtonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        setUpKakaoSignInButton()
        setUpGoogleSignInButton()
        setUpAppleSignInButton()
    }
    
    private func setUpKakaoSignInButton() {
        signInButtonStackView.addArrangedSubview(kakaoSignInButton)
        
        NSLayoutConstraint.activate([
            kakaoSignInButton.heightAnchor.constraint(equalToConstant: 50),
            kakaoSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setUpGoogleSignInButton() {
        signInButtonStackView.addArrangedSubview(googleSignInButton)
        
        NSLayoutConstraint.activate([
            googleSignInButton.heightAnchor.constraint(equalToConstant: 50),
            googleSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
  
    private func setUpAppleSignInButton() {
        signInButtonStackView.addArrangedSubview(appleSignInButton)
        appleSignInButton.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
    }
    
    @objc 
    private func tapGoogleSignInButton() {
        onboardingViewModel.signInWithGoogle(presentViewController: self)
            .sink { result in
                print(result)
            } receiveValue: { idToken in
                print(idToken)
            }.store(in: &self.anyCancellables)
    }
    
    @objc
    private func signInWithApple() {
        onboardingViewModel.signInWithApple()
            .sink { result in
                print(result)
            } receiveValue: { credential in
                print(credential)
            }.store(in: &anyCancellables)
    }
}
