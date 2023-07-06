//
//  CustomEditorViewModel.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import Foundation

public enum CustomComponents: String {
    case segment = "Segment"
    case userIdField = "User Id Field"
    case passwordField = "Password Field"
    case loginButton = "Login Button"
    case signupText = "Signup Text"
    case signupButtton = "Signup Button"
    case forgotPasswordButton = "Forgot Password Button"
    case none = "None"
}

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

class CustomEditorViewModel: ObservableObject {
    @Published var customLoginViewModel = CustomLoginViewModel()
    
    @Published var allScreens: [CustomScreen] = [.login, .signup, .loader]
    @Published var selectedScreen: CustomScreen = .login
    @Published var selectedComponent: CustomComponents = .none
    
    init() {}
}
