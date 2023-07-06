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
        ScrollView {
            VStack {
                loginView()
            }
        }
        
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
//        self.viewModel.errorMessage = "Something went wrong from email"
        
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
    
    func borderColorForPhoneTextfield() -> Color {
        return .black
    }
    
    func cornerRadiusForPhoneTextfield() -> Double {
        return 10
    }
    
    func borderColorForUserIdTextfield() -> Color {
        return .black
    }
    
    func headingTextColorForPasswordTextfield() -> Color {
        return .black
    }
    
    func borderColorForPasswordTextfield() -> Color {
        return .black
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
        // Will need to call api and share reponse directly to viewModel using this function
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if userId == "mohit.kumar@nickelfox.com" && password == "12345" {
                self.viewModel.didGetEmailLoginResponse(withSuccess: true, errorMessage: nil)
            } else {
                self.viewModel.didGetEmailLoginResponse(withSuccess: false, errorMessage: "Incorrect Email or Password")
            }
        }
    }
    
    func didTapSendOTPButton(withPhone phone: String) {
//        Send OTP to device
    }
    
    func loggedInSuccessFully() {
        
    }
    
    func didFailToLogin(withError errorMessage: String) {
        
    }
    
    func didTapForgotPasswordButton(withPhone phone: String) {
        
    }
    
    func didTapForgotPasswordButton(witEmail email: String) {
        
    }
    
    func didTapVerify(otp: String) {
        // Will need to call api and share reponse directly to viewModel using this function
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if otp == "000000" {
                self.viewModel.didGetOTPLoginResponse(withSuccess: true, errorMessage: nil)
            } else {
                self.viewModel.didGetOTPLoginResponse(withSuccess: false, errorMessage: "Incorrect OTP")
            }
        }
    }
}
