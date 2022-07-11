//
//  Filter.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//

import SwiftUI

enum FILTERS {
    case rectangle
    case circle
    case start
    case lines
}

struct Filter: View {
    @EnvironmentObject var viewModel : ViewModel
    var data: FilterModel
    var body: some View {
        GeometryReader { geometry in
            Button {
                if data.isPreview {
                    viewModel.indexFilter = data.filter
                }
            } label: {
                switch data.filter {
                case .circle:
                    FCircle(isPreview: data.isPreview)
                case .rectangle:
                    FReactngle(isPreview: data.isPreview)
                case .lines:
                    FLines(isPreview: data.isPreview)
                case .start:
                    FStart(isPreview: data.isPreview)
                }
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}
