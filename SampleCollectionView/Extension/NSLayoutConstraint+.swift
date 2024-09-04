//
//  NSLayoutConstraint+.swift
//  SampleDelegateApp
//
//  Created by sakiyamaK on 2024/07/15.
//

import UIKit

extension NSLayoutConstraint {
    // returnされるパラメータを使わなくても警告が出ないようにする属性
    @discardableResult
    func priority(_ value: UILayoutPriority) -> Self {
        self.priority = value
        return self
    }
}
