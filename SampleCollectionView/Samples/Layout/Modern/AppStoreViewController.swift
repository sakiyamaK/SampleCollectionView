//
//  AppStoreViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/05.
//

// セクションごとでlayoutを変更する

import UIKit

final class AppStoreViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .null, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UICollectionReusableView.className)
        
        return collectionView
    }()
    
    private func topSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(60)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)

        return section
    }

    private func mainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .absolute(300)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        // 横スクロールの動きを設定
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)

        return section
    }

    private lazy var layout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout.init {
            sectionIndex,
            environment in
            switch sectionIndex {
            case 0:
                // こんな風にsectionごとにメソッドに分けてもいい
                return self.topSection()
            case 1:
                // こんな風にsectionごとにメソッドに分けてもいい
                return self.mainSection()
            case 2:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0/3.0)
                )

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let verticalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [item, item, item])

                let mainGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.95),
                    heightDimension: .absolute(300)
                )

                let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainGroupSize, subitems: [verticalGroup])
                
                let section = NSCollectionLayoutSection(group: mainGroup)
                // 横スクロールの動きを設定
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
                
                // ヘッダ
                // セクションのヘッダーサイズを指定
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )

                section.boundarySupplementaryItems = [
                    header
                ]

                return section
                
            case 3:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0/2.0)
                )

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let verticalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [item, item])

                let mainGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.95),
                    heightDimension: .absolute(300)
                )

                let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainGroupSize, subitems: [verticalGroup])
                
                let section = NSCollectionLayoutSection(group: mainGroup)
                // 横スクロールの動きを設定
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
                
                // ヘッダ
                // セクションのヘッダーサイズを指定
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [
                    header
                ]

                return section
            default:
                return NSCollectionLayoutSection.list(
                    using: .init(appearance: .insetGrouped),
                    layoutEnvironment: environment
                )

            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.applyArroundConstraint(equalTo: self.view)
        collectionView.reloadData()
    }
}

extension AppStoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension AppStoreViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    
    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            6
        case 1:
            6
        case 2:
            10
        case 3:
            30
        default:
            10
        }
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
    
    // ヘッダ/フッダの再利用メソッド
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            // ヘッダの再利用
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionReusableView.className, for: indexPath)
            header.backgroundColor = .yellow
            return header
        default:
            fatalError()
        }
    }
}

#Preview {
    AppStoreViewController()
}
