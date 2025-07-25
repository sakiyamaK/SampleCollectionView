//
//  UIKitView.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/25.
//

import UIKit

// UIViewをUIContentViewに準拠させることでUICollectionViewCellとしてもUITableViewCellとしても使えるようになる
// いちいちUICollectionViewCellやUITableViewCellをそれぞれで継承させなくていい
class UIKitContentView: UIView, UIContentView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UIContentConfigurationに準拠した設定オブジェクトを保持する
    // このプロパティが更新されると、ビューの表示も更新するようにする
    var configuration: UIContentConfiguration {
        didSet {
            // 新しい設定をビューに適用します
            guard let newConfig = configuration as? UIKitContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }

    private let mainLabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let subLabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    init(configuration: UIKitContentConfiguration) {
        // configurationプロパティの初期化は必須です。
        self.configuration = configuration
        super.init(frame: .null)

        // UIのセットアップ
        let stackView = UIStackView(arrangedSubviews: [
            mainLabel,
            UIView(),
            subLabel
        ])
        stackView.axis = .vertical

        addSubview(stackView)

        stackView.applyArroundConstraint(equalTo: self)

        // 初期設定を適用
        apply(configuration: configuration)
    }

    // 設定オブジェクトからデータを取得し、UI要素に反映させるメソッド
    private func apply(configuration: UIKitContentConfiguration) {
        mainLabel.text = configuration.item.title
        subLabel.text = configuration.item.subTitle
        subLabel.isHidden = configuration.item.subTitle == nil
    }
}

// MARK: - Step 2: カスタム設定 (UIContentConfiguration)
// UIContentViewに準拠したUIViewに表示するデータ（状態）を定義する「設計図」
struct UIKitContentConfiguration: UIContentConfiguration {
    // 表示したいデータ
    var item: IdentifableModel

    // この設定に対応するContentView（Step 1で作成）のインスタンスを返します。
    func makeContentView() -> UIView & UIContentView {
        UIKitContentView(configuration: self)
    }

    // セルの状態（選択、ハイライトなど）が変わったときに呼び出される
    // 新しい状態を反映した設定オブジェクトを返す
    func updated(for state: UIConfigurationState) -> UIKitContentConfiguration {
        // ここで state（例: state.isSelected）に応じて見た目を変えることも可能です
        // 例: isSelectedなら文字色を変える、など

        // 状態に応じて変化することがないようなシンプルな実装では、selfをそのまま返しても問題ない
        return self
    }
}
