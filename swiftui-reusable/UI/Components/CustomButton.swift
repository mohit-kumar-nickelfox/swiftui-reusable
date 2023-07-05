//
//  CustomButton.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import SwiftUI

/// Custom Button
/// You can provide title font and color by providing font and foregroundColor moidifier on Custom Button
public struct CustomButton: View {
    
    /// Button action callback
    public var action: (() -> Void)
    
    /// Button title
    public var buttonTitle: String
    
    public var frame: CGRect?
    
    /// Button Background Color
    public var backgroundColor: Color?
    
    /// Button Border Width
    public var borderWidth: Double?
    
    /// Button Border Color
    public var borderColor: Color?
    
    /// Corner Radius
    public var cornerRadius: Double?
    
    public var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                if let color = backgroundColor {
                    color
                        .cornerRadius(cornerRadius ?? 0)
                }
                
                VStack {
                    Text(buttonTitle)
                }
            }
            .frame(width: frame?.width, height: frame?.height)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius ?? 0)
                    .stroke(
                        borderColor ?? .black,
                        lineWidth: borderWidth ?? 0)
            )
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {},
                     buttonTitle: "Login",
                     frame: CGRect(x: 0, y: 0, width: 108, height: 58),
                     backgroundColor: .red,
                     borderWidth: 2,
                     borderColor: .blue,
                     cornerRadius: 40)
    }
}
