//
//  Sample8CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/24.
//

import UIKit

// 普通に何かの配列をそのままデータソースとして使う

final class Sample8CollectionViewController: UIViewController {

    private let viewModel: Sample8CollectionViewModel = .init()

    private lazy var collectionView: UICollectionView = {

        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let listLayout = UICollectionViewCompositionalLayout.list(using: configuration)

        let collectionView = UICollectionView(frame: .null, collectionViewLayout: listLayout)
        // tableviewと同じくdataSourceとdelegateとセルの登録を行う
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Sample4CollectionViewCell.self, forCellWithReuseIdentifier: Sample4CollectionViewCell.className)
        return collectionView
    }()

    private lazy var removeButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Remove Item"
        let action = UIAction(handler: { _ in
            self.viewModel.removeItem()
            // 毎回全セルの再描画が走って負荷が高い
            // 正しくセル番号を指定して更新する処理もあるが、データソースとのindexのずれが出てクラッシュしたりする問題が多い
            self.collectionView.reloadData()
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
                collectionView.reloadData()
            } catch let e {
                print(e)
            }
        }

    }
}

extension Sample8CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension Sample8CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // セルの再利用
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Sample4CollectionViewCell.className, for: indexPath) as! Sample4CollectionViewCell
        let item = viewModel.items[indexPath.item]
        cell.configure(sampleModel: item)
        return cell
    }
}

#Preview {
    Sample8CollectionViewController()
}
