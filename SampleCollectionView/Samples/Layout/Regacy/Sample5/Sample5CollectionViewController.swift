//
//  Sample5CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/04.
//

// layoutを更新する

import UIKit

final class Sample5CollectionViewController: UIViewController {
    private lazy var stackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.addAction(UIAction.init(handler: { action in
            //actionの送り主のクラスを型変換
            let switchView = action.sender as! UISwitch
            //スイッチのON/OFFでcollectionViewのレイアウトを変更
            let number = switchView.isOn ? 3 : 1
            self.collectionView.setCollectionViewLayout(self.layout(number: number), animated: true)
            // なぜかoffsetがずれるのでzeroにする
            self.collectionView.contentOffset = .zero
        }), for: .valueChanged)
        return switchView
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .null, collectionViewLayout: self.layout(number: 1))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()

    func layout(number: Int) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 30, bottom: 0, right: 30)

        // スペーシングを考慮して、セルの幅を計算
        let totalSpacing = layout.minimumInteritemSpacing * CGFloat(number - 1) + layout.sectionInset.left + layout.sectionInset.right
        let totalWidth = UIScreen.main.bounds.width - totalSpacing
        let itemWidth = Int(totalWidth / CGFloat(number))

        // 高さは固定または必要に応じて変更
        layout.estimatedItemSize = CGSize(width: itemWidth, height: 50) // 推定サイズも設定
        layout.itemSize = CGSize(width: itemWidth, height: 50)

        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stackView1)
        stackView1.applyArroundConstraint(equalTo: self.view.safeAreaLayoutGuide)

        stackView1.addArrangedSubview(stackView2)
        stackView1.addArrangedSubview(collectionView)

        stackView2.addArrangedSubview(switchView)

        collectionView.reloadData()
    }
}

extension Sample5CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.className, for: indexPath)
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

extension Sample5CollectionViewController: UICollectionViewDelegate {
}

#Preview {
    Sample5CollectionViewController()
}
