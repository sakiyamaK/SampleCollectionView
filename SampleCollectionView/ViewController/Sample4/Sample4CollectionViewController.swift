//
//  Sample4CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/07.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

//自作のCellクラスを使った実装

import UIKit

final class Sample4CollectionViewController: UIViewController {

  typealias Cell = MyCollectionViewCell
  private let CellNibName = String(describing: Cell.self)
  private let CellID = String(describing: Cell.self)

  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      let cellNib = UINib.init(nibName: CellNibName, bundle: nil)
      collectionView.register(cellNib, forCellWithReuseIdentifier: CellID)
      /*
       UICollectionViewFlowLayoutを設定すればそちらが優先でレイアウトが組まれる
       なければMyCollectionViewCellの誓約にしたがってレイアウトが組まれる
       */
      //      let layout = UICollectionViewFlowLayout()
      //      layout.itemSize = CGSize(width: 150, height: 150)
      //      collectionView.collectionViewLayout = layout
    }
  }

  let items = SampleModel.demoData
}

extension Sample4CollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //セルの再利用
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as? Cell else {
      return UICollectionViewCell()
    }

    let item = items[indexPath.item]
    cell.configure(sampleModel: item)
    return cell
  }
}
