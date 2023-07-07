//
//  CustomLoadersExample.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

struct CustomLoadersExample: View {
    @State var isAnimating: Bool = false
    
    @State var loaders: [CustomLoaderType] = [.arcs, .bars, .blinking, .classic, .rotatingShapes, .rowOfShapes]
    
    let width: Double = 60
    let height: Double = 60
    var body: some View {
        VStack(spacing: 20) {
            
            Button {
                self.isAnimating.toggle()
            } label: {
                Text(isAnimating ? "Stop Animating" : "Animate")
            }
            
            ForEach(loaders, id: \.self) { loader in
                loader.loader(binder: $isAnimating)
                    .frame(width: width, height: height)
            }
        }
    }
}

// MARK: Preview
struct CustomLoadersExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoadersExample()
    }
}
