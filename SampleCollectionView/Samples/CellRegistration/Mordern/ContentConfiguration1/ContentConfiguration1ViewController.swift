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
    @State private var viewModel: ObservableViewModel = .init()

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
