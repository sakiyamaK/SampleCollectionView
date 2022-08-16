//
//  3DCollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2022/08/06.
//  Copyright © 2022 sakiyamaK. All rights reserved.
//

import UIKit
import DeclarativeUIKit

final class ThreeDCollectionViewController: UIViewController {

    override func loadView() {
        super.loadView()
        NotificationCenter.default.addInjectionObserver(self, selector: #selector(setupLayout), object: nil)
        setupLayout()
    }
}

@objc private extension ThreeDCollectionViewController {
    func setupLayout() {
        self.declarative {
            UIView()
        }
    }
}
