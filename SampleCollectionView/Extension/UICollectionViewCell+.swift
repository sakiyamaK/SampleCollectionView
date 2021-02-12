//
//  UICollectionViewCell+.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/07/26.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
  static var nib: UINib { UINib.init(nibName: String(describing: Self.self), bundle: nil) }

  static var reuseIdentifier:String { String(describing: Self.self) }
}
