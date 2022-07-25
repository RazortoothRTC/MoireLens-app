//
//  FStar.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//

import SwiftUI

struct FStart: View{
    var isPreview = false
    var scale: Int
    
    init(isPreview: Bool) {
        self.isPreview = isPreview
        self.scale = Constant.num
    }
    
    var body: some View{
        ZStack{
            ForEach(0..<scale * 5) { i in
                Rectangle()
                    .fill(Color.white)
                    .frame(width: Constant.borderWidth, height: 1000)
                    .rotationEffect(Angle(degrees: Double(90 + (i * 5)) ))
            }
        }
    }
}
