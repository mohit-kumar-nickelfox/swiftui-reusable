//
//  LoginViewExample.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 03/07/23.
//

import SwiftUI

struct LoginViewExample: View {
    var body: some View {
        loginView()
    }
    
    func loginView() -> some View {
        var loginView = CustomLoginView(
            loginAction: loginAction,
            forgotPasswordAction: forgotPasswordTapped,
            signupAction: signupTapped,
            userIdTitle: "Email",
            userIdPlaceholder: "test@example.com",
            passwordTitle: "Password",
            userId: .constant(""),
            password: .constant(""))
        
        loginView.delegate = self
        
        return loginView
    }
    
    func loginAction() {
        print("Login Tapped")
    }
    
    func signupTapped() {
        print("SignUp Tapped")
    }
    
    func forgotPasswordTapped() {
        print("Forgot password tapped")
    }
}

struct LoginViewExample_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewExample()
    }
}

extension LoginViewExample: CustomLoginViewUIProtocol {
    func headingTextColorForUserIdTextfield() -> Color {
        return .black
    }
    
    func headingTextFontForUserIdTextfield() -> Font {
        return .subheadline
    }
    
    func borderWidthForUserIdTextfield() -> Double {
        return 1
    }
    
    func borderColorForUserIdTextfield() -> Color {
        return .black
    }
    
    func cornerRadiusForUserIdTextfield() -> Double {
        return 10
    }
    
    func inputTextFontForUserIdTextfield() -> Font {
        return .body
    }
    
    func headingTextColorForPasswordTextfield() -> Color {
        return .black
    }
    
    func headingFontForPasswordTextfield() -> Font {
        return .subheadline
    }
    
    func borderWidthForPasswordTextfield() -> Double {
        return 1
    }
    
    func borderColorForPasswordTextfield() -> Color {
        return .black
    }
    
    func cornerRadiusForPasswordTextfield() -> Double {
        return 10
    }
    
    func inputTextFontForPasswordTextfield() -> Font {
        return .body
    }
    
    func titleColorForForgotPasswordButton() -> Color {
        return .red
    }
    
    func titleFontForForgotPasswordButton() -> Font {
        return .caption
    }
    
    func titleColorForLoginButton() -> Color {
        return .black
    }
    
    func titleFontForLoginButton() -> Font {
        return .subheadline
    }
    
    func backgroundColorForLoginButton() -> Color {
        return .teal
    }
    
    func borderWidthForLoginButton() -> Double {
        return 0
    }
    
    func borderColorForLoginButton() -> Color {
        return .white
    }
    
    func cornerRadiusForLoginButton() -> Double {
        return 8
    }
    
    
}
