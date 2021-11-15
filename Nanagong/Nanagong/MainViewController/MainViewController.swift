//
//  MainViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import Combine
import UIKit

final class MainViewController: UIViewController {
        
    private unowned var coordinator: AppCoordinator
    private let viewModel: MainViewModel
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(coordinator: AppCoordinator, viewModel: MainViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.checkHasToken()
    }
    
    private func bind() {
        viewModel.$state
            .dropFirst()
            .sink { [weak self] state in
                switch state {
                case .signedOut:
                    self?.coordinator.presentWelcomeView()
                    
                case .signedIn:
                    self?.coordinator.presentSignedInView()
                }
            }.store(in: &anyCancellables)
    }
}
