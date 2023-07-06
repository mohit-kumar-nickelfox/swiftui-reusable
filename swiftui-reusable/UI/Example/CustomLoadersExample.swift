//
//  CustomLoadersExample.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

struct CustomLoadersExample: View {
    @State var isAnimating: Bool = false
    
    let width: Double = 60
    let height: Double = 60
    var body: some View {
        VStack(spacing: 20) {
            
            Button {
                self.isAnimating.toggle()
            } label: {
                Text(isAnimating ? "Stop Animating" : "Animate")
            }
            
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
    }
}

// MARK: Preview
struct CustomLoadersExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoadersExample()
    }
}

public enum CustomLoaderType {
    case basic, arcs, bars, blinking, classic, rotatingShapes, rowOfShapes
    
    func loader(binder: Binding<Bool>) -> some View {
        return VStack {
            switch self {
            case .basic:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .tint(Color.black)
            case .arcs:
                Arcs(animate: binder)
            case .bars:
                Bars(animate: binder)
            case .blinking:
                Blinking(animate: binder)
            case .classic:
                Classic(animate: binder)
            case .rotatingShapes:
                RotatingShapes(animate: binder)
            case .rowOfShapes:
                RowOfShapes(animate: binder)
            }
        }
    }
}
