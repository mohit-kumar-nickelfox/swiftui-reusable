//
//  CustomScreen.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import Foundation

public enum CustomScreen {
    case login
    case signup
    case loader
    
    var title: String {
        switch self {
        case .login:
            return "Login"
        case .signup:
            return "Signup"
        case .loader:
            return "Loader"
        }
    }
    
    var components: [CustomComponents] {
        switch self {
        case .login:
            return [
                .segment,
                .userIdField,
                .passwordField,
                .loginButton,
                .signupText,
                .signupButtton,
                .forgotPasswordButton
            ]
        case .signup:
            return []
        case .loader:
            return []
        }
    }
}
