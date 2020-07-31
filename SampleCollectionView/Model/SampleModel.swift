//
//  SampleData.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/06.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import Foundation

struct SampleModel: Codable {
  var id: Int
  var title: String? = nil
  var iconUrlStr: String? = nil
  var description: String? = nil
}

extension SampleModel {
  static var demoData: [SampleModel] {
    let json = """
[
{
  "id": 0,
  "title": "タイトル1",
  "iconUrlStr": "https://via.placeholder.com/150/888888/FFFFFF",
  "description": "詳細情報です"
},
{
  "id": 1,
  "title": "タイトル2",
  "iconUrlStr": "https://via.placeholder.com/150/888888/FFFFFF",
  "description": "詳細情報です\\n詳細情報です\\n詳細情報です\\n詳細情報です\\n詳細情報です"
},
{
  "id": 2,
  "title": "タイトル3",
  "iconUrlStr": "https://via.placeholder.com/150/888888/FFFFFF"
}
]
""".data(using: .utf8)!

    guard let demo = try? JSONDecoder().decode([SampleModel].self, from: json) else {
      return []
    }
    return [[SampleModel]](repeating: demo, count: 7).reduce([]) { (result, value) -> [SampleModel] in
      result + value
    }
  }
}
