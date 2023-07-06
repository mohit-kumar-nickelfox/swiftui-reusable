//
//  CustomEditorView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

struct CustomEditorView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel = CustomEditorViewModel()
    
    let editorAnimationDuration: Double = 0.4
    
    let screens: [CustomScreen] = [.login, .signup]
    
    @State var showEditor: Bool = true
    var body: some View {
        ZStack {
            
            // Dynamic View depending upon selection
            viewToShow
            
            // Editor View
            editorView
            
            editorButton
            
                
        }.navigationBarTitleDisplayMode(.inline)
        
    }
    
   
}

// MARK: Helper Functions
extension CustomEditorView {
    
    var viewToShow: some View {
        VStack {
            switch self.viewModel.selectedScreen {
            case .login: loginScreen()
            case .signup: signupScreen()
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
            userId: .constant(""),
            password: .constant(""),
            phone: .constant(""))
        return loginView
    }
    
    func signupScreen() -> some View {
        let signupScreen = CustomSignupView(viewModel: self.viewModel.customLoginViewModel)
        return signupScreen
    }
}



// MARK: Preview
struct CustomEditorView_Previews: PreviewProvider {
    static var previews: some View {
        CustomEditorView()
    }
}
