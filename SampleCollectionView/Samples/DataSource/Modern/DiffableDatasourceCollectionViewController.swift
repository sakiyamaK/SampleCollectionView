//
//  DiffableDatasourceCollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/24.
//

import UIKit

// 配列をUICollectionViewDiffableDataSourceに登録して使う

final class DiffableDatasourceCollectionViewController: UIViewController {

    private let viewModel: DiffbaleDatasourceViewModel = .init()

    // SwiftUIのように差分を自動管理するUICollectionViewDiffableDataSourceを用意する
    // <Int, String>は<Section番号, データ型を一意に区別する型>
    private lazy var diffableDataSource = UICollectionViewDiffableDataSource<Int, String>(
        collectionView: collectionView
    ) { collectionView, indexPath, itemId in

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DiffbaleCollectionViewCell.className,
            for: indexPath
        ) as! DiffbaleCollectionViewCell

        let item = self.viewModel.items.first(where: { $0.id == itemId })!
        cell.configure(sampleModel: item)
        return cell
    }

    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let listLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: listLayout)
        collectionView.register(DiffbaleCollectionViewCell.self, forCellWithReuseIdentifier: DiffbaleCollectionViewCell.className)
        return collectionView
    }()

    private lazy var removeButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Remove Item"
        let action = UIAction(handler: { _ in
            Task {
                self.viewModel.removeItem()
                // diffableDataSourceから現在の内部データの状態をsnapshotとして取得する
                // collectionView自身を更新する必要はない
                var snapshot = self.diffableDataSource.snapshot()
                // snapshotをまっさらにする
                snapshot.deleteAllItems()
                // snapshotに新しいデータを登録する
                snapshot.appendItems(self.viewModel.items.map(\.id))
                // diffableDataSourceに新しいsnapshotを登録する
                // collectionView自身を更新する必要はない
                // *** diffableDataSourceが内部でデータの差分があるところだけ更新する ***
                await self.diffableDataSource.apply(snapshot, animatingDifferences: true)
            }
        })
        let button = UIButton(configuration: configuration, primaryAction: action)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = UIStackView()
        stackView.axis = .vertical

        self.view.addSubview(stackView)

        stackView.applyArroundConstraint(equalTo: self.view.safeAreaLayoutGuide)

        stackView.addArrangedSubview(removeButton)

        stackView.addArrangedSubview(collectionView)

        // 非同期処理を実行するのでTaskで囲う
        Task {
            do {
                try await viewModel.fetchItems()

                // snapshot = 現在のDataSourceの状態を安全に取得する
                // 非同期でどこかでセルの状態が変わったとしてもsnapshotを取った時点で完全に独立しているので影響はない(クラッシュしない)
                // ここでは新規にsnapshotのインスタンスを作成してdiffableDataSourceに渡している
                // collectionView自身を更新する必要はない
                var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
                snapshot.appendSections([0])
                snapshot.appendItems(viewModel.items.map(\.id))
                await self.diffableDataSource.apply(snapshot, animatingDifferences: true)

            } catch let e {
                print(e)
            }
        }

    }
}

extension DiffableDatasourceCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

#Preview {
    Sample8CollectionViewController()
}
