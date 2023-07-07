//
//  CustomTextField.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import SwiftUI

/// Custom textfield
/// You can set text font and color by providing font and foreground modifiers to CustomTextField
public struct CustomTextField: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var placeholder: String
    @Binding var text: String
    
    public var isSecureField: Bool
    
    @Binding public var title: String
    
    @Binding public var titleColor: Color
    
    @Binding public var titleFont: Font
    
    @Binding public var textColor: Color
    
    @Binding public var textFont: Font
    
    @Binding public var errorText: String
    
    /// TextField Border width
    @Binding public var borderWidth: Double
    
    /// TextField Border color
    @Binding public var borderColor: Color
    
    /// TextField corner radius
    @Binding public var cornerRadius: Double
    
    /// Keyboard Type
    public var keyboardType: UIKeyboardType?
    
    var onEditingChanged: ((_ changed: Bool)->())?
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(self.titleColor)
                .font(self.titleFont)
            
            
            if isSecureField {
                SecureField(
                    placeholder,
                    text: self.$text)
                .foregroundColor(self.textColor)
                .font(textFont)
                .padding()
                .overlay(
                    RoundedRectangle(
                        cornerRadius: cornerRadius
                    )
                    .stroke(
                        borderColor,
                        lineWidth: borderWidth
                    )
                )
                .textContentType(.password)
                .keyboardType(self.keyboardType ?? .default)
                .onTapGesture {
                    (self.onEditingChanged ?? {_ in})(true)
                }
            } else {
                TextField(
                    placeholder,
                    text: self.$text,
                    onEditingChanged: { changed in
                        
                        (self.onEditingChanged ?? {_ in})(changed)
                    })
                .foregroundColor(self.textColor)
                .font(textFont)
                .padding()
                .overlay(
                    RoundedRectangle(
                        cornerRadius: cornerRadius
                    )
                    .stroke(
                        borderColor,
                        lineWidth: borderWidth
                    )
                )
                .keyboardType(self.keyboardType ?? .default)
            }
            
            Text(self.errorText)
                .foregroundColor(.red)
                .font(.caption)
                .padding(.top, -5)
                .padding(.leading, 20)
        }
        
        
        
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(
            placeholder: "Input Text",
            text: .constant("Test String"),
            isSecureField: true,
            title: .constant("Title"),
            titleColor: .constant(.gray),
            titleFont: .constant(.body),
            textColor: .constant(.black),
            textFont: .constant(.body),
            errorText: .constant(""),
            borderWidth: .constant(5),
            borderColor: .constant(.blue),
            cornerRadius: .constant(22))
    }
}
