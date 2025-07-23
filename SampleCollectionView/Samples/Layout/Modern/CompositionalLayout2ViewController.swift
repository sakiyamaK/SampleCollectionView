//
//  CompositionalLayout2ViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/05.
//

// 入れ子なグループ

import UIKit

final class CompositionalLayout2ViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {

        // 右側
        let itemSize1 = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )

        let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
        item1.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)

        let groupSize1 = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let group1 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize1, subitems: [item1])
        group1.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 0)

        // 左側
        let itemSize2 = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )

        let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)

        // 全体
        let mainGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(300)
        )
        // NSCollectionLayoutGroupはItemも入るしNSCollectionLayoutGroupを入れ子で登録することもできる
        let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainGroupSize, subitems: [item2, group1])
        mainGroup.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 10)


        let section = NSCollectionLayoutSection(group: mainGroup)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.applyArroundConstraint(equalTo: self.view)
        collectionView.reloadData()
    }
}

extension CompositionalLayout2ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DLog(indexPath)
    }
}

extension CompositionalLayout2ViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // セルの再利用
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.className, for: indexPath)
        // indexPathで背景色を変えてみた
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

#Preview {
    CompositionalLayout2ViewController()
}
