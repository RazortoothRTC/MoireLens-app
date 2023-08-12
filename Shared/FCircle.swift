//
//  FCircle.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//  Edited by Astra on 1/8/23.
//

import SwiftUI

struct FCircle: View{
    var isPreview = false
    var color = 1.0
    var numShapes: Int
    
    init(isPreview: Bool, color: Double) {
        self.isPreview = isPreview
        self.numShapes = Constant.num / (isPreview ? 4 : 2)
        self.color = color
    }
    
    var body: some View{
            ZStack(alignment: .center){
                ForEach(Array(stride(from: 0, to: numShapes, by: 5)), id: \.self) { i in
                    Circle()
                        .stroke(Color(white: color), lineWidth: Constant.borderWidth)
                    .frame(
                        width: Constant.minSizeShape + (CGFloat(i) * (isPreview ? 1 : 2)),
                        height: Constant.minSizeShape + (CGFloat(i) * (isPreview ? 1 : 2)),
                        alignment: .center)
                }
            }
    }
}

