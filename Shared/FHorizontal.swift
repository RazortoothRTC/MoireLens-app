//
//  FHorizontal.swift
//  MoireLens (iOS)
//
//  Created by EJiii on 1/18/23.
//

import SwiftUI

struct FHorizontal: View{
    var isPreview = false
    var color = 0.0
    var scale: Int
    init(isPreview: Bool, color: Double) {
        self.isPreview = isPreview
        self.scale = isPreview ? 4 : 10
        self.color = color
    }
    var body: some View{
        GeometryReader { geometry in
            VStack{
                ForEach(0..<Constant.height, id: \.self) { i in
                        Rectangle()
                        .fill(Color(white: color))
                        .frame(
                            width: Constant.sizeWidthPreview * 3,
                            height: Constant.borderWidth)
                    Spacer()
                    }
            }
        }
    }
}
