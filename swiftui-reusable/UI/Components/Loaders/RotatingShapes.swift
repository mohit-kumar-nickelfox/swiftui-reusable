//
//  RotatingShapes.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

public struct RotatingShapes: View {
    @Binding private var isAnimating: Bool
    public let count: UInt
    public let content: AnyView

    public init<Content: View>(animate: Binding<Bool>, count: UInt = 6, size: CGFloat = 8, content: () -> Content) {
        self._isAnimating = animate
        self.count = count
        self.content = AnyView(content().frame(width: size, height: size))
    }

    public init(animate: Binding<Bool>, count: UInt = 6, size: CGFloat = 8) {
        self.init(animate: animate, count: count) {
            Circle().frame(width: size, height: size)
        }
    }

    private func animatingScale(forIndex index: Int) -> CGFloat { CGFloat(index+1)/CGFloat(count) }

    public var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count), id: \.self) { index in
                item(forIndex: index, in: geometry.size)
                    .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                    .animation(
                        Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatCount(isAnimating ? .max : 1, autoreverses: false),
                        value: isAnimating
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        content
            .scaleEffect(isAnimating ? animatingScale(forIndex: index) : 1 )
            .offset(y: geometrySize.width/10 - geometrySize.height/2)
    }
}

extension RotatingShapes: iActivityIndicatorStyle {
    public init(animate: Binding<Bool>) {
        self.init(animate: animate, count: 6, size: 8)
    }
}
