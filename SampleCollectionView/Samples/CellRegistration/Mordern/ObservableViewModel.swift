//
//  Untitled.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/24.
//

import Foundation

@Observable
final class ObservableViewModel {

    var items: [IdentifableModel] = []

    func fetchItems() async throws {
        // 実際はサーバーと通信してデータを受け取る
        try await Task.sleep(for: .seconds(1))
        items = (1...100).compactMap { index -> IdentifableModel? in
            IdentifableModel(title: "\(index)のタイトル", subTitle: "\(index)のサブタイトル")
        }
    }

    func removeItem() {
        if !items.isEmpty {
            items.removeFirst()
        }
    }
}
