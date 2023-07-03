//
//  LoginViewExample.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 03/07/23.
//

import SwiftUI

struct LoginViewExample: View {
    
    @State var userId: String = ""
    @State var password: String = ""
    @State var phone: String = ""
    
    var viewModel = CustomLoginViewModel()
    var body: some View {
        loginView()
    }
    
    func loginView() -> some View {
        viewModel.delegate = self
        var loginView = CustomLoginView(
            viewModel: viewModel,
            loginAction: loginAction,
            forgotPasswordAction: forgotPasswordTapped,
            signupAction: signupTapped,
            userIdTitle: "Email",
            userIdPlaceholder: "test@example.com",
            passwordTitle: "Password",
            phoneTitle: "Phone",
            userId: self.$userId,
            password: self.$password,
            phone: self.$phone)
        
        loginView.delegate = self
        
        return loginView
    }
    
    func loginAction() {
        print("Login Tapped")
        self.viewModel.errorMessage = "Something went wrong from email"
        
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

// MARK: CustomLoginViewUIProtocol
extension LoginViewExample: CustomLoginViewUIProtocol {
    func headingTextColorForPhoneTextfield() -> Color {
        return .black
    }
    
    func headingTextFontForPhoneTextfield() -> Font {
        return .subheadline
    }
    
    func borderWidthForPhoneTextfield() -> Double {
        return 1
    }
    
    func borderColorForPhoneTextfield() -> Color {
        return .black
    }
    
    func cornerRadiusForPhoneTextfield() -> Double {
        return 10
    }
    
    func inputTextFontForPhoneTextfield() -> Font {
        return .body
    }
    
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

// MARK: CustomLoginViewModelProtocol
extension LoginViewExample: CustomLoginViewModelProtocol {
    func didTapLoginButtonWith(userId: String, andPassword password: String) {
        self.viewModel.errorMessage = "Something went wrong from email"
    }
    
    func didTapSendOTPButton(withPhone phone: String) {
        self.viewModel.errorMessage = "Something went wrong from phone"
    }
    
    func loggedInSuccessFully() {
        
    }
    
    func didFailToLogin(withError errorMessage: String) {
        
    }
    
    func didTapForgotPasswordButton(withPhone phone: String) {
        
    }
    
    func didTapForgotPasswordButton(witEmail email: String) {
        
    }
    
    
}
