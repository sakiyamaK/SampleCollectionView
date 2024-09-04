//
//  CompositionalLayout3ViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/05.
//

// テーブルビューの機能にする

import UIKit

final class CompositionalLayout3ViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        // 見た目など全て標準のふるまい(Appearance)にする
        let appearance = UICollectionLayoutListConfiguration.Appearance.plain
        // 設定(Configuration)にふるまいを登録して初期化する
        let configuration = UICollectionLayoutListConfiguration(appearance: appearance)
        // レイアウトを特別なlistにしてその設定を登録して初期化する
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.applyArroundConstraint(equalTo: self.view)
        collectionView.reloadData()
    }
}

extension CompositionalLayout3ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DLog(indexPath)
    }
}

extension CompositionalLayout3ViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    CompositionalLayout3ViewController()
}
