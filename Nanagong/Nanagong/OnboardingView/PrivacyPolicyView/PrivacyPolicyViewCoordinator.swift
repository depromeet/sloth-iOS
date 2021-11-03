//
//  PrivacyPolicyViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import SlothDesignSystemModule
import UIKit

final class PrivacyPolicyViewCoordinator: NSObject, Coordinator {
    
    private let presenter: UIViewController?
    private var privacyPolicyViewController: PrivacyPolicyViewController?
    
    init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
    func start() {
        let privacyPolicyViewController = PrivacyPolicyViewController()
        
        privacyPolicyViewController.modalPresentationStyle = .custom
        privacyPolicyViewController.transitioningDelegate = self
        
        self.privacyPolicyViewController = privacyPolicyViewController
        
        presenter?.present(privacyPolicyViewController, animated: true, completion: nil)
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

