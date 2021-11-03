//
//  SignInViewCoordinator.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/04.
//

import SlothDesignSystemModule
import UIKit

final class SignInViewCoordinator: NSObject, Coordinator {

    private let presenter: UIViewController?
    private let signInViewControllerFactory: SignInViewControllerFactory
    private var signInViewController: SignInViewController?
    
    init(presenter: UIViewController?, signInViewControllerFactory: SignInViewControllerFactory) {
        self.presenter = presenter
        self.signInViewControllerFactory = signInViewControllerFactory
    }
    
    func start() {
        let signInViewController = signInViewControllerFactory.makeSignInViewController()
        signInViewController.modalPresentationStyle = .custom
        signInViewController.transitioningDelegate = self
        
        presenter?.present(signInViewController, animated: true, completion: nil)
    }
}

extension SignInViewCoordinator: DimPresentationControllerDelegate {
    func frameOfPresentedViewInContainerView(frame: CGRect) -> CGRect {
        let presentationControllerHeight: CGFloat = 270
        
        return CGRect(x: 0, y: frame.height - presentationControllerHeight,
                      width: frame.width, height: presentationControllerHeight)
    }
}

extension SignInViewCoordinator: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimPresentationController.init(presentaionDelegate: self,
                                              presentedViewController: presented,
                                              presenting: presenting)
    }
}
