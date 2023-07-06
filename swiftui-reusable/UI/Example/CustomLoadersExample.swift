//
//  CustomLoadersExample.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

struct CustomLoadersExample: View {
    @State var isAnimating: Bool = false
    
    let width: Double = 80
    let height: Double = 80
    var body: some View {
//        ScrollView {
            VStack(spacing: 20) {
                
                Button {
                    self.isAnimating.toggle()
                } label: {
                    Text(isAnimating ? "Stop Animating" : "Animate")
                }
                
//                HStack{}.frame(height: 100)

                Arcs(animate: self.$isAnimating)
                    .frame(width: width, height: height)
                
                Bars(animate: self.$isAnimating)
                    .frame(width: width, height: height)
                
                Blinking(animate: self.$isAnimating)
                    .frame(width: width, height: height)
                
                Classic(animate: self.$isAnimating)
                    .frame(width: width, height: height)
                
                RotatingShapes(animate: self.$isAnimating)
                    .frame(width: width, height: height)

                RowOfShapes(animate: self.$isAnimating)
                    .frame(width: width, height: height)
            }
//        }
//        .frame(width: UIScreen.main.bounds.size.width,
//                height: UIScreen.main.bounds.size.height)
    }
}

struct CustomLoadersExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoadersExample()
    }
}
