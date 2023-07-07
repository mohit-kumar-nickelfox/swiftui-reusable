//
//  CustomEditorView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

struct CustomEditorView: View {
    
    let animationDuration: Double = 0.5
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel = CustomEditorViewModel()
    
    let editorAnimationDuration: Double = 0.4
    
    @State var textfieldTitleFont: Font = .body
    @State var textfieldTitleColor: Color = .black
    @State var textfieldBorderWidth: Double = 2
    @State var textfieldBorderColor: Color = .black
    @State var textfieldCornerRadius: Double = 8
    @State var textfieldTextFont: Font = .body
    @State var textfieldTextColor: Color = .black
    
    @State var showEditor: Bool = true
    
    @State var openTextFieldEditor: Bool = false
    var body: some View {
        ZStack {
            
            // Dynamic View depending upon selection
            viewToShow
            
            // Editor View
            editorView
            
            editorButton
            
            textfieldEditor
            
                
        }.navigationBarTitleDisplayMode(.inline)
        
    }
    
    var textfieldEditor: some View {
        VStack {
            if self.openTextFieldEditor {
                TextfieldEditorView(
                    title: .constant("Phone"),
                    placeholder: .constant("Not configurable yet"),
                    titleColor: self.$textfieldTitleColor,
                    borderColor: self.$textfieldBorderColor,
                    textColor: self.$textfieldTextColor,
                    cornerRadius: self.$textfieldCornerRadius,
                    borderWidth: self.$textfieldBorderWidth,
                    showTextfieldEditor: self.$openTextFieldEditor)
                .animation(.easeIn(
                    duration: animationDuration),
                           value: self.openTextFieldEditor)
                .transition(.asymmetric(insertion: .move(edge: .bottom).animation(.easeIn(duration: animationDuration)), removal: .move(edge: .bottom).animation(.easeIn(duration: animationDuration))))
            }
        }
    }
    
   
}

// MARK: Helper Functions
extension CustomEditorView {
    
    var viewToShow: some View {
        VStack {
            switch self.viewModel.selectedScreen {
            case .login: loginScreen()
            case .signup: signupScreen()
            case .loader: CustomLoadersExample()
            }
        }
    }
    
    func loginScreen() -> some View {
        let loginView = CustomLoginView(
            viewModel: self.viewModel.customLoginViewModel,
            loginAction: {},
            forgotPasswordAction: {},
            userIdTitle: "Email/UserId",
            userIdPlaceholder: "Enter you email",
            passwordTitle: "Password",
            phoneTitle: "Phone",
            textfieldTitleColor: self.$textfieldTitleColor,
            textfieldTitleFont: self.$textfieldTitleFont,
            textfieldBorderWidth: self.$textfieldBorderWidth,
            textfieldBorderColor: self.$textfieldBorderColor,
            textfieldCornerRadius: self.$textfieldCornerRadius,
            textfieldTextFont: self.$textfieldTextFont,
            textfieldTextColor: self.$textfieldTextColor,
            userId: .constant(""),
            password: .constant(""),
            phone: .constant(""))
        return loginView
    }
    
    func signupScreen() -> some View {
        let signupScreen = CustomSignupView(
            viewModel: self.viewModel.customLoginViewModel,
            textfieldTitleFont: self.$textfieldTitleFont,
            textfieldTitleColor: self.$textfieldTitleColor,
            textfieldBorderWidth: self.$textfieldBorderWidth,
            textfieldBorderColor: self.$textfieldBorderColor,
            textfieldCornerRadius: self.$textfieldCornerRadius,
            textfieldTextFont: self.$textfieldTextFont,
            textfieldTextColor: self.$textfieldTextColor
        )
        return signupScreen
    }
}



// MARK: Preview
struct CustomEditorView_Previews: PreviewProvider {
    static var previews: some View {
        CustomEditorView()
    }
}
