//
//  Sample5CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/07.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

//自作のCellクラスを使った実装

import UIKit

final class Sample5CollectionViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.register(MyCollectionViewCell2.nib, forCellWithReuseIdentifier: MyCollectionViewCell2.reuseIdentifier)
    }
  }

  let items = SampleModel.demoData
}

extension Sample5CollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //セルの再利用
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell2.reuseIdentifier, for: indexPath) as? MyCollectionViewCell2 else {
      return UICollectionViewCell()
    }

    let item = items[indexPath.item]
    cell.configure(sampleModel: item)
    return cell
  }
}

extension Sample5CollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width:CGFloat = 200
//    let item = items[indexPath.item]
//    let size = Cell.calcSize(width: width, sampleModel: item)
    return CGSize(width: width, height: 0)
  }
}

