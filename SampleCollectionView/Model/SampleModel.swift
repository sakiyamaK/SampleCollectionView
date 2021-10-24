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
    static func getDemoData(count: Int) -> [SampleModel] {
        [[SampleModel]](repeating: SampleModel._demoData, count: count).reduce([]) { (result, value) -> [SampleModel] in
            result + value
        }

    }

    static var demoData: [SampleModel] {
        getDemoData(count: 7)
    }

    private static var _demoData: [SampleModel] {
        let json = """
[
{
  "id": 0,
  "title": "タイトル1",
  "iconUrlStr": "https://picsum.photos/200",
  "description": "詳細情報です"
},
{
  "id": 1,
  "title": "タイトル2",
  "iconUrlStr": "https://picsum.photos/200/300",
  "description": "詳細情報です\\n詳細情報です\\n詳細情報です\\n詳細情報です\\n詳細情報です"
},
{
  "id": 2,
  "title": "タイトル3",
  "iconUrlStr": "https://via.placeholder.com/150/888888/FFFFFF"
},
{
  "id": 3,
  "title": "タイトル4",
  "iconUrlStr": "https://via.placeholder.com/150/888888/AAAAAA"
},
{
  "id": 4,
  "title": "タイトル5",
  "iconUrlStr": "https://picsum.photos/300"
},
{
  "id": 5,
  "title": "タイトル6",
  "iconUrlStr": "https://via.placeholder.com/150/888888/FFAABB"
},
{
  "id": 6,
  "title": "タイトル7",
  "iconUrlStr": "https://picsum.photos/400"
}

]
""".data(using: .utf8)!
        return (try? JSONDecoder().decode([SampleModel].self, from: json)) ?? []
    }
}
