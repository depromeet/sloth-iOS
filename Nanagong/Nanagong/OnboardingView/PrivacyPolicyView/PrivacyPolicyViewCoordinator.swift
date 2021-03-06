//
//  PrivacyPolicyViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import SlothDesignSystemModule
import UIKit

final class PrivacyPolicyViewCoordinator: NSObject, Coordinator {
    
    private var privacyPolicyViewController: PrivacyPolicyViewController?
    private unowned var presenter: UIViewController?
    private unowned var parentCoordinator: OnBoardingViewCoordinator
    
    init(parentCoordinator: OnBoardingViewCoordinator, presenter: UIViewController?) {
        self.parentCoordinator = parentCoordinator
        self.presenter = presenter
    }
    
    func start() {
        let privacyPolicyViewController = PrivacyPolicyViewController(coordinator: self)
        
        privacyPolicyViewController.modalPresentationStyle = .custom
        privacyPolicyViewController.transitioningDelegate = self
        
        self.privacyPolicyViewController = privacyPolicyViewController
        
        presenter?.present(privacyPolicyViewController, animated: true, completion: nil)
    }
    
    func signInDone() {
        privacyPolicyViewController?.dismiss(animated: true, completion: nil)
        parentCoordinator.present(with: .next)
    }
}

extension PrivacyPolicyViewCoordinator: DimPresentationControllerDelegate {
    func frameOfPresentedViewInContainerView(frame: CGRect) -> CGRect {
        let presentationControllerHeight: CGFloat = 280
        
        return CGRect(x: 0, y: frame.height - presentationControllerHeight,
                      width: frame.width, height: presentationControllerHeight)
    }
}

extension PrivacyPolicyViewCoordinator: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimPresentationController.init(presentaionDelegate: self,
                                              presentedViewController: presented,
                                              presenting: presenting)
    }
}

