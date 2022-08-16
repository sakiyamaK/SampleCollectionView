//
//  CompositionalLayout08ViewController.swift
//  SampleCompositonalLayout
//
//  Created by  on 2021/4/3.
//

// ヘッダフッダ
// 追加読み込み
// ウォーターフォール
// 1~2列

import UIKit

final class CompositionalLayout08ViewController: UIViewController {
    private var items: [SampleImageModel] = []
    private let limit: Int = 10
    private var offset: Int = 10
    private var loading: Bool = false

    private weak var segmentControll: UISegmentedControl!
    private weak var collectionView: UICollectionView!

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        declarative {
            UIStackView.vertical {
                UISegmentedControl(items: ["First", "Second"]).imperative {
                    let segmentControll = $0 as! UISegmentedControl
                    segmentControll.selectedSegmentIndex = 0
                    segmentControll.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
                }
                .assign(to: &segmentControll)
                .padding()

                UICollectionView {
                    UICollectionViewFlowLayout()
                }
                .assign(to: &collectionView)
                .registerCellClass(UIImageViewCell.self, forCellWithReuseIdentifier: UIImageViewCell.reuseId)
                .registerViewClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UICollectionReusableView.reuseId)
                .backgroundColor(.systemGray)
                .dataSource(self)
                .delegate(self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = layout

        SampleImageModel.load(times: 100) { [unowned self] items in
            self.items = items
            self.collectionView.reloadData()
        }
    }

    @objc func changeSegment() {
        updateLayout()
    }
}

private extension CompositionalLayout08ViewController {
    var layout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout.waterfall(
            footerHeight: 80,
            numberOfColumn: CGFloat(segmentControll.selectedSegmentIndex + 1),
            numberOfItemsInSection: { [weak self] section in
                self!.collectionView.numberOfItems(inSection: section)
            },
            cellHeight: { [weak self] width, idx in
                guard let self = self, idx < self.items.count else { return 0 }
                let size = self.items[idx].image?.size ?? .zero
                let aspect = CGFloat(size.height) / CGFloat(size.width)
                let height = width * aspect
                return height
            }
        )
    }

    func updateLayout() {
        collectionView.collectionViewLayout = layout
        collectionView.alpha = 0.0
        collectionView.reloadData()
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionView.alpha = 1.0
        })
    }
}

extension CompositionalLayout08ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.reachedBottom, !loading else { return }
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.offset += self.limit
            self.collectionView.reloadData()
            self.loading = false
        }
    }
}

extension CompositionalLayout08ViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        items[safe: 0 ..< offset].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        (collectionView.dequeueReusableCell(withReuseIdentifier: UIImageViewCell.reuseId, for: indexPath) as! UIImageViewCell)
            .configure(sample: items[safe: 0 ..< offset][indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionReusableView.reuseId, for: indexPath)
            cell.declarative {
                UIActivityIndicatorView().imperative {
                    let activity = $0 as! UIActivityIndicatorView
                    activity.startAnimating()
                }
            }
            return cell
        default:
            fatalError()
        }
    }
}

private extension UICollectionViewCompositionalLayout {
    private static func createHeader(height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem? {
        guard height > 0 else { return nil }
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(height)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    private static func createFooter(height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem? {
        guard height > 0 else { return nil }
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(height)
            ),
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
    }

    static func waterfall(contentInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8),
                          headerHeight: CGFloat = 0,
                          footerHeight: CGFloat = 0,
                          horizontalSpace: CGFloat = 8,
                          verticalSpace: CGFloat = 8,
                          numberOfColumn: CGFloat = 1,
                          numberOfItemsInSection: @escaping ((Int) -> Int),
                          cellHeight: @escaping (((width: CGFloat, index: Int)) -> CGFloat)) -> UICollectionViewLayout
    {
        UICollectionViewCompositionalLayout { section, environment -> NSCollectionLayoutSection? in

            // 各列の最後のitemのmaxYを保存するための辞書
            // 最初は全て0で初期化する
            var itemMaxYPerColumns: [Int: CGFloat] = Dictionary(
                uniqueKeysWithValues: (0 ..< Int(numberOfColumn)).map { ($0, 0) }
            )

            // セルひとつの横幅
            let width = (environment.container.effectiveContentSize.width
                - (contentInsets.leading + contentInsets.trailing)
                - (numberOfColumn - 1) * horizontalSpace) / numberOfColumn

            let items: [NSCollectionLayoutGroupCustomItem] = (0 ..< numberOfItemsInSection(section)).map { idx in
                // セルひとつの縦幅
                let height = cellHeight((width, idx))

                // セルの配置座標を計算
                let currentColumn = idx % Int(numberOfColumn)
                let currentRow = idx / Int(numberOfColumn)
                let preItemMaxY = (itemMaxYPerColumns[currentColumn] ?? 0.0)
                let y = preItemMaxY + (currentRow == 0 ? 0.0 : verticalSpace)
                let x = environment.container.contentInsets.leading + width * CGFloat(currentColumn) + horizontalSpace * CGFloat(currentColumn)

                // セルの配置frame
                let frame = CGRect(x: x, y: y, width: width, height: height)
                itemMaxYPerColumns[currentColumn] = frame.maxY
                let item = NSCollectionLayoutGroupCustomItem(frame: frame)
                return item
            }

            let layoutSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: items.isEmpty ? .fractionalWidth(1.0) : .absolute(items.last!.frame.maxY)
            )

            // group
            let group = NSCollectionLayoutGroup.custom(layoutSize: layoutSize) { _ in
                items
            }

            // なぜかgroupが反応しない
            //            group.contentInsets = .init(top: 0, leading: contentInsets.leading, bottom: 0, trailing: contentInsets.trailing)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = contentInsets

            /*
             header footerの設定
             */
            let boundaryItems: [NSCollectionLayoutBoundarySupplementaryItem] =
                [createHeader(height: headerHeight), createFooter(height: footerHeight)]
                    .compactMap { $0 }
            if !boundaryItems.isEmpty {
                // セクションに登録
                section.boundarySupplementaryItems = boundaryItems
            }

            return section
        }
    }
}
