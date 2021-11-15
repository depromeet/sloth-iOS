//
//  OnBoardingViewController.swift
//  Nanagong
//
//  Created by 임승혁 on 2021/10/28.
//

import UIKit
import Combine
import SlothDesignSystemModule

final class OnBoardingViewController: UIViewController {

    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Sloth.gray600
        label.numberOfLines = 2
        
        let text = "나보다 나무늘보가\n공부 열심히 한다"
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.Sloth.primary400, range: (text as NSString).range(of: "나"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.Sloth.primary400, range: NSRange(location: 4, length: 1))
        attributedString.addAttribute(.foregroundColor, value: UIColor.Sloth.primary400, range: (text as NSString).range(of: "공"))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.17
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        
        label.attributedText = attributedString
        label.font = .primarySlothFont(ofSize: 28)
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "나무늘보도 못 이기나요?"
        label.font = .primarySlothFont(ofSize: 14)
        label.textColor = .Sloth.gray500
        
        return label
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "sloth_character_stand")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var startOnBoardingButton: UIControl = {
        let button = SlothButton.init(buttonStyle: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("나나공 시작하기")
        button.addTarget(self, action: #selector(startSignIn), for: .allEvents)
        
        return button
    }()
    
    private unowned var coordinator: OnBoardingViewCoordinator
    private let viewModel: OnBoardingViewModel
    private var anyCancellables: Set<AnyCancellable> = .init()
    private var characterImageViewLandscapeConstraints: [NSLayoutConstraint] = []
    private var characterImageViewPotraitHeightConstraints: [NSLayoutConstraint] = []
    
    init(coordinator: OnBoardingViewCoordinator, viewModel: OnBoardingViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        render()
    }
    
    private func render() {
        viewModel.$viewState
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] state in
                self?.coordinator.present(with: state)
            }
            .store(in: &anyCancellables)
    }
    
    @objc
    private func startSignIn() {
        viewModel.present()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        setUpMainTitleLabel()
        setUpSubTitleLabel()
        setUpCharacterImageView()
        setUpStartOnBoardingButton()
    }
    
    private func setUpMainTitleLabel() {
        view.addSubview(mainTitleLabel)
        
        NSLayoutConstraint.activate([
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
        ])
    }
    
    private func setUpSubTitleLabel() {
        view.addSubview(subTitleLabel)
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 12)
        ])
    }
    
    private func setUpCharacterImageView() {
        view.addSubview(characterImageView)
        setUpCharacterImageViewConstraints()
        
        if view.frame.height > view.frame.width {
            NSLayoutConstraint.activate(characterImageViewPotraitHeightConstraints)
        } else {
            NSLayoutConstraint.activate(characterImageViewLandscapeConstraints)
        }
    }
    
    private func setUpCharacterImageViewConstraints() {
        characterImageViewPotraitHeightConstraints = [
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 1.2)
        ]
        
        characterImageViewLandscapeConstraints = [
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
    }
    
    private func setUpStartOnBoardingButton() {
        view.addSubview(startOnBoardingButton)
        
        NSLayoutConstraint.activate([
            startOnBoardingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startOnBoardingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            startOnBoardingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            startOnBoardingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            NSLayoutConstraint.deactivate(characterImageViewLandscapeConstraints)
            NSLayoutConstraint.activate(characterImageViewPotraitHeightConstraints)
        } else {
            NSLayoutConstraint.deactivate(characterImageViewPotraitHeightConstraints)
            NSLayoutConstraint.activate(characterImageViewLandscapeConstraints)
        }
    }
}
