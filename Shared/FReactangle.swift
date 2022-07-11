//
//  FReactangle.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//

import SwiftUI

struct FReactngle: View{
    var isPreview = false
    var numShapes: Int
    
    init(isPreview: Bool) {
        self.isPreview = isPreview
        self.numShapes = Constant.num / (isPreview ? 3 : 1)
    }
    
    var body: some View{
        ZStack {
            ForEach(Array(stride(from: 0, to: numShapes, by: 4)), id: \.self) { i in
                Rectangle()
                    .stroke(Color.white, lineWidth: Constant.borderWidth)
                    .frame(
                        width: Constant.minSizeShape + (CGFloat(i) * 4),
                        height: Constant.minSizeShape + (CGFloat(i) * 4),
                        alignment: .center)
            }
        }
    }
}
