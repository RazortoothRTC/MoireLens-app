//
//  FLines.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//

import SwiftUI

struct FLines: View{
    var isPreview = false
    var color = 0.0
    var scale: Int
    init(isPreview: Bool, color: Double) {
        self.isPreview = isPreview
        self.scale = isPreview ? 3 : 5
        self.color = color
    }
    var body: some View{
        GeometryReader { geometry in
            HStack{
                ForEach(0..<Constant.num, id: \.self) { i in
                        Rectangle()
                        .fill(Color(white: color))
                        .frame(
                            width: Constant.borderWidth,
                            height: geometry.size.height)
                    Spacer()
                    }
            }
        }
    }
}
