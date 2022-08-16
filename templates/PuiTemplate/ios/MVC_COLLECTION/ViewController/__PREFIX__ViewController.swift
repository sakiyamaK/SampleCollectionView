//
//  __PREFIX__ViewController.swift
//  __TARGET__
//
//  Created by __USERNAME__ on __YEAR__/__MONTH__/__DAY__.
//

import UIKit

final class __PREFIX__ViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {}
    }
}

extension __PREFIX__ViewController: UICollectionViewDelegate {}

extension __PREFIX__ViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        0
    }

    func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
