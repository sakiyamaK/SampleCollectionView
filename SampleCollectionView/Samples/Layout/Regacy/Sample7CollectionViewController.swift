//
//  Sample7CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/04.
//

// 横スクロール

import UIKit

final class Sample7CollectionViewController: UIViewController {
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
        switchView.addAction(
            UIAction.init(handler: {
                action in
                //actionの送り主のクラスを型変換
                let switchView = action.sender as! UISwitch
                //スイッチのON/OFFでcollectionViewのレイアウトを変更
                self.collectionView.setCollectionViewLayout(
                    self.layout(isVertical: !switchView.isOn),
                    animated: true
                )
                // なぜかoffsetがずれるのでzeroにする
                self.collectionView.contentOffset = .zero
            }),
            for: .valueChanged
        )
        return switchView
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: self.layout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()
    
    func layout(isVertical: Bool = true) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = isVertical ? .vertical : .horizontal
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        
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

extension Sample7CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 100
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

extension Sample7CollectionViewController: UICollectionViewDelegate {
}

#Preview {
    Sample7CollectionViewController()
}
