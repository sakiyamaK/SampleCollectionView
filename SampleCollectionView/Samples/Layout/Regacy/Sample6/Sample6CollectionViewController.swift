//
//  Sample6ViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/05.
//

// カスタムレイアウト

import UIKit

final class Sample6CollectionViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        // 自前のレイアウトを用意
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: MosaicLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.applyArroundConstraint(equalTo: self.view)
        collectionView.reloadData()
    }
}

extension Sample6CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.className, for: indexPath)
        switch indexPath.item % 5 {
        case 0:
            cell.backgroundColor = .red
        case 1:
            cell.backgroundColor = .green
        case 2:
            cell.backgroundColor = .blue
        case 3:
            cell.backgroundColor = .black
        case 4:
            cell.backgroundColor = .brown
        default:
            break
        }
        return cell
    }
}

extension Sample6CollectionViewController: UICollectionViewDelegate {
}

#Preview {
    Sample6CollectionViewController()
}
