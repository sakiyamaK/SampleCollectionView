//
//  Sample3CollectionViewController.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/04.
//

// カスタムセルを登録する

import UIKit

final class Sample4CollectionViewController: UIViewController {
    
    private let sampleModels: [SampleModel] = [
        SampleModel(title: "短いタイトル", subTitle: "サブタイトル1"),
        SampleModel(title: "少し長めのタイトル", subTitle: "サブタイトル2"),
        SampleModel(title: "これはさらに長いタイトルです", subTitle: ""),
        SampleModel(title: "タイトル", subTitle: "短い"),
        SampleModel(title: "非常に長いタイトルがここにあります", subTitle: "サブタイトル4"),
        SampleModel(title: "普通のタイトル", subTitle: nil),
        SampleModel(title: "短い", subTitle: "これはサブタイトルです"),
        SampleModel(title: "長いタイトルの例", subTitle: "短いサブタイトル"),
        SampleModel(title: "タイトルが少し長いかもしれません", subTitle: "サブタイトル5"),
        SampleModel(title: "サンプルモデルのタイトル", subTitle: nil),
        SampleModel(title: "短めのタイトル", subTitle: "サブタイトル7"),
        SampleModel(title: "長いタイトルと短いサブタイトル", subTitle: "サブタイトル8"),
        SampleModel(title: "ここにタイトルがあります", subTitle: "サブタイトル9"),
        SampleModel(title: "タイトルが長い", subTitle: "サブタイトル10"),
        SampleModel(title: "短いタイトル", subTitle: "長いサブタイトルの例です"),
        SampleModel(title: "通常の長さのタイトル", subTitle: "サブタイトル11"),
        SampleModel(title: "非常に短い", subTitle: ""),
        SampleModel(title: "タイトルはここに", subTitle: "サブタイトル13"),
        SampleModel(title: "サンプル", subTitle: "サブタイトルが長い例です"),
        SampleModel(title: "タイトル"),
        SampleModel(title: "長めのタイトル", subTitle: "サブタイトル15")
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Sample4CollectionViewCell.self, forCellWithReuseIdentifier: Sample4CollectionViewCell.className)
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.view.addSubview(collectionView)
        collectionView.applyArroundConstraint(equalTo: self.view)
        collectionView.reloadData()
    }
}

extension Sample4CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return sampleModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Sample4CollectionViewCell.className, for: indexPath) as! Sample4CollectionViewCell
        cell.configure(sampleModel: sampleModels[indexPath.item])
        
        return cell
    }
}

extension Sample4CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DLog(indexPath)
    }
}

extension Sample4CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat
        if indexPath.item%3 == 0 {
            width = collectionView.frame.width
        } else {
            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            width = collectionView.frame.width / 2 - flowLayout.minimumLineSpacing
        }
        return CGSize(width: width, height: 100)
    }
}

#Preview {
    Sample4CollectionViewController()
}
