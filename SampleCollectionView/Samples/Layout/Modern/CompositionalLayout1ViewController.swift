//
//  CompositionalLayout1ViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/05.
//

// CompositionalLayoutを使った最小実装

import UIKit

final class CompositionalLayout1ViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .null, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        // アイテム(セル)の大きさをグループの大きさに対する比率で求める
        let itemSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0/3.0),
            heightDimension: NSCollectionLayoutDimension.fractionalHeight(1.0)
        )

        // アイテム設定に大きさを登録してインスタンスを作る
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 10, trailing: 5)

        // グループサイズの横幅をコレクションビューの横幅と同じ、高さを44にる
        let groupSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(300)
        )
        // グループの大きさとアイテムの種類を登録する
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // セクションにグループを登録する
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        // レイアウトにセクションを登録する
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

extension CompositionalLayout1ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension CompositionalLayout1ViewController: UICollectionViewDataSource {
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
    CompositionalLayout1ViewController()
}
