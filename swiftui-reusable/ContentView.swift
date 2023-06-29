//
//  ContentView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        CustomLoginView(
            loginAction: loginAction,
            forgotPasswordAction: forgotPasswordTapped,
            signupAction: signupTapped,
            userIdTitle: "Email",
            userIdPlaceholder: "test@example.com",
            passwordTitle: "Password",
            userId: .constant(""),
            password: .constant(""))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
