//
//  FReactangle.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//  Edited by Astra on 1/8/23.
//

import SwiftUI

struct FReactngle: View{
    var isPreview = false
    var color = 0.0
    var numShapes: Int
    
    init(isPreview: Bool, color: Double) {
        self.isPreview = isPreview
        self.numShapes = Constant.num / (isPreview ? 5 : 2)
        self.color = color
    }
    
    var body: some View{
        ZStack {
            ForEach(Array(stride(from: 0, to: numShapes, by: 4)), id: \.self) { i in
                Rectangle()
                    .stroke(Color(white: color), lineWidth: Constant.borderWidth)
                    .frame(
                        width: Constant.minSizeShape + (CGFloat(i) * 2),
                        height: Constant.minSizeShape + (CGFloat(i) * 2),
                        alignment: .center)
            }
        }
    }
}

