//
//  FLines.swift
//  MoireLens (iOS)
//
//  Created by Delta on 11/7/22.
//

import SwiftUI

struct FLines: View{
    var isPreview = false
    var scale: Int
    
    init(isPreview: Bool) {
        self.isPreview = isPreview
        self.scale = isPreview ? 3 : 5
    }
    
    var body: some View{
        GeometryReader { geometry in
            HStack{
                ForEach(0..<Constant.num) { i in
                        Rectangle()
                        .fill(Color.black)
                        .frame(
                            width: Constant.borderWidth,
                            height: geometry.size.height)
                    Spacer()
                    }
            }
        }
    }
}
