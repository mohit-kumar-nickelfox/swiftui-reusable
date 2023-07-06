//
//  CustomSlider.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 05/07/23.
//

import SwiftUI

public struct CustomSlider: View {

    // MARK: - Value
    // MARK: Private
    @Binding var number: CGFloat
    
    var thumbColor: Color


    // MARK - View
    // MARK: Public
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            LockerSlider(
                value: $number,
                in: 0...50,
                step: 1,
                thumbColor: thumbColor)
                .frame(height: 24)
                .padding(.bottom, 0)
        }
        .onChange(of: self.number, perform: { newValue in
            if Double(Int(newValue)) - newValue == 0 {
//                createHapticFeedback()
            }
        })
    }
}

struct LockerSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {

    // MARK: - Value
    // MARK: Private
    @Binding private var value: V
    private let bounds: ClosedRange<V>
    private let step: V.Stride

    private let length: CGFloat    = 24
    private let lineWidth: CGFloat = 2

    @State private var ratio: CGFloat   = 0
    @State private var startX: CGFloat? = nil
    
    var thumbColor: Color


    // MARK: - Initializer
    init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, thumbColor: Color) {
        _value  = value
    
        self.bounds = bounds
        self.step   = step
        self.thumbColor = thumbColor
    }


    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: length / 2)
                    .foregroundColor(.yellow)
                    .frame(height: 8)
            
                // Thumb
                Circle()
                    .foregroundColor(thumbColor)
                    .frame(width: 24, height: 24)
                    .offset(x: (proxy.size.width - 12) * ratio)
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged({ updateStatus(value: $0, proxy: proxy) })
                                .onEnded { _ in startX = nil })
            }
            .frame(height: 24)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                                    .onChanged({ update(value: $0, proxy: proxy) }))
            .onAppear {
                ratio = min(1, max(0,CGFloat(value / bounds.upperBound)))
            }
            
            .onChange(of: self.value) { newValue in
                ratio = min(1, max(0,CGFloat(value / bounds.upperBound)))
            }
        }
    }

    // MARK: Private
    private var overlay: some View {
        RoundedRectangle(cornerRadius: (length + lineWidth) / 2)
            .stroke(Color.gray, lineWidth: lineWidth)
            .frame(height: length + lineWidth)
    }


    // MARK: - Function
    // MARK: Private
    private func updateStatus(value: DragGesture.Value, proxy: GeometryProxy) {
        guard startX == nil else { return }
    
        let delta = value.startLocation.x - (proxy.size.width - length) * ratio
        startX = (length < value.startLocation.x && 0 < delta) ? delta : value.startLocation.x
    }

    private func update(value: DragGesture.Value, proxy: GeometryProxy) {
        guard let x = startX else { return }
        startX = min(length, max(0, x))
    
        var point = value.location.x - x
        let delta = proxy.size.width - length
    
        // Check the boundary
        if point < 0 {
            startX = value.location.x
            point = 0
        
        } else if delta < point {
            startX = value.location.x - delta
            point = delta
        }
    
        // Ratio
        var ratio = point / delta
    
    
        // Step
        if step != 1 {
            let unit = CGFloat(step) / CGFloat(bounds.upperBound)
        
            let remainder = ratio.remainder(dividingBy: unit)
            if remainder != 0 {
                ratio = ratio - CGFloat(remainder)
            }
        }
    
        self.ratio = ratio
        self.value = V(bounds.upperBound) * V(ratio)
    }
}

// MARK: Preview
struct CustomSlider_Previews: PreviewProvider {
    @State var sliderValue: CGFloat = 0.0
    static var previews: some View {
        CustomSlider(number: .constant(0.5), thumbColor: .black)
    }
}
