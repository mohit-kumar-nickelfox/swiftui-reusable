//
//  CustomLoaderType.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 07/07/23.
//

import SwiftUI

public enum CustomLoaderType {
    case basic, arcs, bars, blinking, classic, rotatingShapes, rowOfShapes
    
    public func loader(binder: Binding<Bool>) -> some View {
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
