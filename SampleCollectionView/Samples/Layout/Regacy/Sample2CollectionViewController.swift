//
//  Sample2CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/04.
//

// ヘッダとフッダの登録

import UIKit

final class Sample2CollectionViewController: UIViewController {

    private let HeaderID = "header"
    private let FooterID = "footer"
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        // セルのサイズ
        layout.itemSize = CGSize(width: 100, height: 100)
        // 行ごとの余白
        layout.minimumLineSpacing = 5
        // セクションごとの配置位置の余白を設定する
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20)
        // (*4) ヘッダとフッダの高さ
        layout.headerReferenceSize = CGSize(width: 0, height: 300)
        layout.footerReferenceSize = CGSize(width: 100, height: 100)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        
        // ヘッダとフッダの登録
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.applyArroundConstraint(equalTo: self.view)
        collectionView.reloadData()
    }

}

extension Sample2CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DLog(indexPath)
    }
}

extension Sample2CollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // セクションの数
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            10
        case 1:
            5
        default:
            0
        }
    }

//    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
//        return 10
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(collectionView.contentOffset)
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
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderID, for: indexPath)
            header.backgroundColor = .yellow
            return header
        case UICollectionView.elementKindSectionFooter:
            // フッダの再利用
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterID, for: indexPath)
            footer.backgroundColor = .purple
            return footer
        default:
            // kindがなぜか文字列で定義されているため、switchで書くとそれ以外の場合も処理を書かないとswiftの文法上ビルドできない
            // 実際はここの処理が動くことはないためエラーとする
            fatalError()
        }
    }
}

#Preview {
    Sample2CollectionViewController()
}
