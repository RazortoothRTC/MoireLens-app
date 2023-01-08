//
//  FStar.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//

import SwiftUI

struct FStart: View{
    var isPreview = false
    var color = 1.0
    var scale: Int
    
    init(isPreview: Bool, color: Double) {
        self.isPreview = isPreview
        self.scale = Constant.num
        self.color = color
    }
    
    var body: some View{
        ZStack{
            ForEach(0..<scale * 5, id: \.self) { i in
                Rectangle()
                    .fill(Color(white: color))
                    .frame(width: Constant.borderWidth, height: 1000)
                    .rotationEffect(Angle(degrees: Double(90 + (i * 5)) ))
            }
        }
    }
}
