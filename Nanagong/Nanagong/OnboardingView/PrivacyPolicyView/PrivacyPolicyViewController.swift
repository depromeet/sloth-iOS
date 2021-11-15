//
//  PrivacyPolicyViewController.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/30.
//

import UIKit
import SlothDesignSystemModule

final class PrivacyPolicyViewController: UIViewController {
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.17
        label.attributedText = NSMutableAttributedString(string: "나나공을 이용하시려면\n개인정보 동의가 필요해요", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        label.font = .primarySlothFont(ofSize: 24)
        
        return label
    }()
    
    private lazy var detailPolicyLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSAttributedString(
            string: "'나나공' 서비스 개인정보 처리 방침",
            attributes: [
                NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
            ])
        label.attributedText = attributedString
        label.font = .primarySlothFont(ofSize: 16)
        label.textColor = .Sloth.gray400
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(pushDetailPolicyViewController))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let hStackView = UIStackView.init()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.alignment = .fill
        hStackView.distribution = .fillEqually
        hStackView.spacing = 13
        
        return hStackView
    }()
    
    private lazy var agreePolicyButton: UIControl = {
        let button = SlothButton.init(buttonStyle: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("동의하고 시작하기")
        button.addTarget(self, action: #selector(agreePocily), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cancelButton: UIControl = {
        let button = SlothButton.init(buttonStyle: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소")
        button.addTarget(self, action: #selector(cancelPocilyAgree), for: .touchUpInside)
        
        return button
    }()
    
    private unowned var coordinator: PrivacyPolicyViewCoordinator
    
    init(coordinator: PrivacyPolicyViewCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        setUpDescriptionLabel()
        setUpDetailPolicyLabel()
        setUpButtonStackView()
    }
    
    private func setUpDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 36),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setUpDetailPolicyLabel() {
        view.addSubview(detailPolicyLabel)
        
        NSLayoutConstraint.activate([
            detailPolicyLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            detailPolicyLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 23)
        ])
    }
    
    private func setUpButtonStackView() {
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: detailPolicyLabel.bottomAnchor, constant: 47),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        setUpCancelButton()
        setUpAgreePolicyButton()
    }
    
    private func setUpAgreePolicyButton() {
        buttonStackView.addArrangedSubview(agreePolicyButton)
    }
    
    private func setUpCancelButton() {
        buttonStackView.addArrangedSubview(cancelButton)
    }
    
    @objc
    private func cancelPocilyAgree() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func agreePocily() {
        coordinator.signInDone()
    }
    
    @objc
    private func pushDetailPolicyViewController() {
        print("개인정보 처리방침 웹뷰로 이동")
    }
}
