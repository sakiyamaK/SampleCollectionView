//
//  SwiftUICellCollectionViewController.swift
//  SampleCollectionView
//
//  Created by  on 2021/11/3.
//

import UIKit

final class SwiftUICellCollectionViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
    }
  }
}

extension SwiftUICellCollectionViewController: UICollectionViewDelegate {

}

extension SwiftUICellCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    UICollectionViewCell()
  }
}