//
//  Blinking.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

public struct Blinking: View {
    @Binding private var isAnimating: Bool
    public let count: UInt
    public let size: CGFloat

    public init(animate: Binding<Bool>, count: UInt = 8, size: CGFloat = 16) {
        self._isAnimating = animate
        self.count = count
        self.size = size
    }

    public var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count), id: \.self) { index in
                item(forIndex: index, in: geometry.size)
                    .frame(width: geometry.size.width, height: geometry.size.height)

            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        let angle = 2 * CGFloat.pi / CGFloat(count) * CGFloat(index)
        let x = (geometrySize.width/2 - size/2) * cos(angle)
        let y = (geometrySize.height/2 - size/2) * sin(angle)
        return Circle()
            .frame(width: size, height: size)
            .scaleEffect(isAnimating ? 0.5 : 1)
            .opacity(isAnimating ? 0.25 : 1)
            .animation(
                Animation
                    .default
                    .repeatCount(isAnimating ? .max : 1, autoreverses: true)
                    .delay(Double(index) / Double(count) / 2),
                value: self.isAnimating
            )
            .offset(x: x, y: y)
    }
}

extension Blinking: iActivityIndicatorStyle {
    public init(animate: Binding<Bool>) {
        self.init(animate: animate, count: 8, size: 16)
    }
}
