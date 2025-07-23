//
//  Untitled.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/24.
//

import UIKit
import SwiftUI

final class ContentConfiguration1ViewController: UIViewController {

    // @State属性をつけて$viewModelでBindingできるようにする
    @State private var viewModel: DiffbaleDatasource2ViewModel = .init()

    private lazy var diffableDataSource = UICollectionViewDiffableDataSource<Int, String>(
        collectionView: collectionView
    ) {
        collectionView,
        indexPath,
        itemId in

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UICollectionViewCell.className,
            for: indexPath
        )

        let item = self.$viewModel.items.first(where: { $0.id == itemId })!

         // UIHostingConfigurationでセルのレイアウトをSwiftUIで組める
        cell.contentConfiguration = UIHostingConfiguration {
            SwiftUIView(
                model: item
            )
        }
        return cell
    }

    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let listLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        // レイアウトを登録してインスタンスを用意
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: listLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)

        collectionView.applyArroundConstraint(equalTo: self.view.safeAreaLayoutGuide)

        // 非同期処理を実行するのでTaskで囲う
        Task {
            do {
                try await viewModel.fetchItems()

                // snapshot = 現在のDataSourceの状態を安全に取得する
                // 非同期でどこかでセルの状態が変わったとしてもsnapshotを取った時点で完全に独立しているので影響はない(クラッシュしない)
                // ここでは新規にsnapshotのインスタンスを作成してdiffableDataSourceに渡している
                // collectionView自身を更新する必要はない
                var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
                let itemIds: [String] = viewModel.items.map(\.id)
                snapshot.appendSections([0])
                snapshot.appendItems(itemIds)
                await self.diffableDataSource.apply(snapshot, animatingDifferences: true)

            } catch let e {
                print(e)
            }
        }

    }
}

#Preview {
    ContentConfiguration1ViewController()
}
