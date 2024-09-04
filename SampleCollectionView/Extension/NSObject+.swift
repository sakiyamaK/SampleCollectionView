//
//  NSObject+.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/04.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: self)
    }
}
