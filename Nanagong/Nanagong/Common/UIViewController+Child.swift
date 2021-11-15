//
//  UIViewController+Child.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import UIKit

extension UIViewController {
    
    // MARK: - Methods
    public func addFullScreen(childViewController child: UIViewController) {
        guard child.parent == nil else {
            return
        }
        
        addChild(child)
        view.addSubview(child.view)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: child.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
        ])
        
        child.didMove(toParent: self)
    }
    
    public func remove(childViewController child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        guard child.parent != nil else {
            return
        }
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
