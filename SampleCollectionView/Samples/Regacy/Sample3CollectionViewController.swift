//
//  Sample3CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/04.
//

// Cellごとで大きさを変える

import UIKit

final class Sample3CollectionViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
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

extension Sample3CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 15
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

/*
 UICollectionViewDelegateFlowLayoutを継承して大きさを変えるメソッドを実装する
 
 UICollectionViewDelegateFlowLayoutはUICollectionViewDelegateにも準拠しているため
 UICollectionViewDelegateを書く必要はない
 
 indexPathごとに呼ばれるのでCellごとに大きさを変えることができる
 */
extension Sample3CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }

        let num: CGFloat = 3
        let a = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right -
            (num - 1) * flowLayout.minimumInteritemSpacing

        let width = CGFloat(Int(a / num))
        let height = CGFloat((indexPath.item % 5 + 1) * 50)

        print(collectionView.frame.width)
        print(flowLayout.minimumInteritemSpacing)
        print(width)

        return CGSize(width: width, height: height)
    }
}

#Preview {
    Sample3CollectionViewController()
}
