//
//  UIViewController+.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2021/10/22.
//  Copyright © 2021 sakiyamaK. All rights reserved.
//

import UIKit

// MARK: - containerview
extension UIViewController {
    func addContainer(viewController: UIViewController, containerView: UIView) {
        self.addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    func removeContainer(viewController: UIViewController) {
        viewController.willMove(toParent: self)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
