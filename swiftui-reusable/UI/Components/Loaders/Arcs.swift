//
//  Arcs.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

public struct Arcs: View {
    @Binding private var isAnimating: Bool
    public let count: UInt
    public let width: CGFloat
    public let spacing: CGFloat

    public init(animate: Binding<Bool>, count: UInt = 3, width: CGFloat = 2, spacing: CGFloat = 1) {
        self._isAnimating = animate
        self.count = count
        self.width = width
        self.spacing = spacing
    }

    public var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count), id: \.self) { index in
                item(forIndex: index, in: geometry.size)
                    .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                    .animation(
                        Animation.default
                            .speed(Double.random(in: 0.2...0.5))
                            .repeatCount(isAnimating ? .max : 1, autoreverses: false),
                        value: self.isAnimating
                    )
            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        Group { () -> Path in
            var p = Path()
            p.addArc(center: CGPoint(x: geometrySize.width/2, y: geometrySize.height/2),
                     radius: geometrySize.width/2 - width/2 - CGFloat(index) * (width + spacing),
                     startAngle: .degrees(0),
                     endAngle: .degrees(Double(Int.random(in: 120...300))),
                     clockwise: true)
            return p.strokedPath(.init(lineWidth: width))
        }
        .frame(width: geometrySize.width, height: geometrySize.height)
    }
}

extension Arcs: iActivityIndicatorStyle {
    public init(animate: Binding<Bool>) {
        self.init(animate: animate, count: 3, width: 2, spacing: 1)
    }
}

public protocol iActivityIndicatorStyle: View {
    init(animate: Binding<Bool>)
}
