//
//  SwiftUIView.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/24.
//

import SwiftUI

struct SwiftUIView: View {

    @Binding var model: IdentifableModel

    var body: some View {
        VStack {
            Text("\(model.title)")
            Spacer()
            if let subTitle = model.subTitle {
                Text("\(subTitle)")
            }
        }
    }
}
