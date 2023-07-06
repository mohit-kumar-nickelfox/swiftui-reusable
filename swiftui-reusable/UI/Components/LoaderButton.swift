//
//  LoaderButton.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

struct LoaderButton: View {
    @State var animateLoader = false
    @Binding var isAnimating: Bool
    @Binding var loaderType: CustomLoaderType
    
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
    var body: some View {
        
        Button {
            self.action()
        } label: {
            
            ZStack {
                if let color = backgroundColor {
                    color
                        .cornerRadius(cornerRadius ?? 0)
                }
                
                VStack {
                    if isAnimating {
                        VStack {
                            loaderType.loader(binder: $animateLoader)
                                .tint(.black)
                        }.frame(width: 24, height: 24)
                    } else {
                        Text(buttonTitle)
                    }
                }
            }
            .frame(width: frame?.width, height: frame?.height)
            
            
        }
        .onChange(of: self.isAnimating) { newValue in
            self.animateLoader = newValue
        }
    }
}

// MARK: Preview
struct LoaderButton_Previews: PreviewProvider {
    static var previews: some View {
        LoaderButton(
            isAnimating: .constant(false),
            loaderType: .constant(.classic),
            action: {},
            buttonTitle: "Send",
            frame: CGRect(x: 0, y: 0, width: 108, height: 58),
            backgroundColor: .red,
            borderWidth: 2,
            borderColor: .blue,
            cornerRadius: 40)
    }
}
