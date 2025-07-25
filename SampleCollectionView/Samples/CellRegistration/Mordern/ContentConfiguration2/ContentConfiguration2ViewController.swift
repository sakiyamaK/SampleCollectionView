//
//  ContentConfiguration2ViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/25.
//
import UIKit

final class ContentConfiguration2ViewController: UIViewController {

    private var viewModel: ObservableViewModel = .init()

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

        let item = self.viewModel.items.first(where: { $0.id == itemId })!

         // contentConfigurationにUIContentViewに準拠したUIViewをセルのレイアウトに利用できる
        // UIContentViewに準拠したUIViewはUITableViewでも使えるし、普通のUIViewとしても使える
        // もういちいちUICollectionViewCellやUITableViewCellを継承させなくていい
        cell.contentConfiguration = UIKitContentConfiguration(item: item)
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
