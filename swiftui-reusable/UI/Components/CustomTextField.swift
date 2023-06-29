//
//  CustomTextField.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import SwiftUI

/// Custom textfield
/// You can set text font and color by providing font and foreground modifiers to CustomTextField
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var isSecureField: Bool
    
    /// TextField Border width
    var borderWidth: Double? = nil
    
    /// TextField Border color
    var borderColor: Color? = nil
    
    /// TextField corner radius
    var cornerRadius: Double? = nil
    
    /// Keyboard Type
    var keyboardType: UIKeyboardType?
    
    var body: some View {
        
        
        if isSecureField {
            SecureField(
                placeholder,
                text: self.$text)
            .padding()
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius ?? 0
                )
                .stroke(
                    borderColor ?? .black,
                    lineWidth: borderWidth ?? 0
                )
            )
            .textContentType(.password)
            .keyboardType(self.keyboardType ?? .default)
        } else {
            TextField(
                placeholder,
                text: self.$text)
            .padding()
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius ?? 0
                )
                .stroke(
                    borderColor ?? .black,
                    lineWidth: borderWidth ?? 0
                )
            )
            .keyboardType(self.keyboardType ?? .default)
        }
        
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(
            placeholder: "Input Text",
            text: .constant("Test String"),
            isSecureField: true,
            borderWidth: 5,
            borderColor: .blue,
            cornerRadius: 22)
    }
}
