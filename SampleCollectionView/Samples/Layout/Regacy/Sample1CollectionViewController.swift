//
//  Sample1CollectionViewController.swift

// UICollectionViewを使った最小実装

import UIKit

final class Sample1CollectionViewController: UIViewController {

    // UICollectionViewのインスタンスを返す即時実行されるクロージャ
    // lazyをつけると初めてここにアクセスした時に呼び出される
    // そうしないとselfが生成前のためdataSourceとかに代入できない
    private lazy var collectionView: UICollectionView = {
        // レイアウトを決める
        // UICollectionViewLayoutを継承したUICollectionViewFlowLayoutクラス
        // StoryboardでUICollectionViewを設定するとデフォルトがこれ
        let layout = UICollectionViewFlowLayout()
        // レイアウトを登録してインスタンスを用意
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // tableviewと同じくdataSourceとdelegateとセルの登録を行う
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ここで初めてlazyなcollectionViewに代入されている即時実行関数が実行される
        self.view.addSubview(collectionView)
        // collectionViewに制約を貼る
        collectionView.applyArroundConstraint(equalTo: self.view)
        // reloadDataで画面更新
        // collectionViewはこれを呼ばなくてもなぜか最初はreloadDataしてくれるが一応呼び出した
        collectionView.reloadData()
    }
}

extension Sample1CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DLog(indexPath)
    }
}

extension Sample1CollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        // セクションごとのセルの数
        // この例ではセクション数の指定がないので1セクションでそこに100セルある
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
    Sample1CollectionViewController()
}
