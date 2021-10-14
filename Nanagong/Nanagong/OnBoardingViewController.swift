//
//  OnBoardingViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/04.
//

import Combine
import UIKit
import KakaoSDKAuth
import GoogleSignIn
import AuthenticationServices

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
            
            self.kakaoSessionManager.loginWithKakao()
                .sink { result in
                    print(result)
                } receiveValue: { token in
                    let vc = ViewController(token: token)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
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
    
    private let kakaoSessionManager: KakaoSessionManager
    private let appleSessionManager: AppleSessionMananger
    private let googleSessionManager: GoogleSessiongManager
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(kakaoSessionManager: KakaoSessionManager,
         googleSessionManager: GoogleSessiongManager,
         appleSessionManager: AppleSessionMananger) {
        self.kakaoSessionManager = kakaoSessionManager
        self.googleSessionManager = googleSessionManager
        self.appleSessionManager = appleSessionManager
      
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
        googleSessionManager.signIn(presentViewController: self)
            .flatMap { [weak self] user -> AnyPublisher<String, GoogleSessionManagerError> in
                guard let self = self else {
                    return Empty(completeImmediately: true).eraseToAnyPublisher()
                }
                
                return self.googleSessionManager.fetchToken(user: user)
            }
            .sink { result in
                print(result)
            } receiveValue: { idToken in
                print(idToken)
            }.store(in: &self.anyCancellables)
    }
    
    @objc
    private func loginWithApple() {
        appleSessionManager.signIn()
            .sink { result in
                print(result)
            } receiveValue: { credential in
                print(credential)
            }.store(in: &anyCancellables)
    }
}

final class ViewController: UIViewController {
    
    private let token: OAuthToken
    
    init(token: OAuthToken) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = token.accessToken
        label.numberOfLines = 0
        label.textAlignment = .center
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
