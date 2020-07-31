//
//  UICollectionViewCell+.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/07/26.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
  static var reuseIdentifier:String { String(describing: Self.self) }
}
