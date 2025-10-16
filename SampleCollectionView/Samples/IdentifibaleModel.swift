//
//  IdentifibaleModel.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/24.
//
import Foundation

struct IdentifableModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var subTitle: String?
}
