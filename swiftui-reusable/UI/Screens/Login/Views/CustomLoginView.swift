//
//  CustomLoginView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import SwiftUI

struct CustomLoginView: View {
    
    // Actions
    
    var loginAction: ()->Void
    
    var forgotPasswordAction: (()->Void)
    
    var signupAction: (()->Void)?
    
    // UserId vars
    
    /// User Id Textfiled title
    var userIdTitle: String
    
    @State var userIdTitleColor: Color?
    
    @State var userIdTitleFont: Font?
    
    @State var userIdTextFieldBorderWidth: Double?
    
    @State var userIdTextFieldBorderColor: Color?
    
    @State var userIdTextFieldCornerRadius: Double?
    
    @State var userIdTextFont: Font?
    
    /// User Id Textfiled placeholder
    var userIdPlaceholder: String
    
    // Password vars
    
    /// Password Textfiled title
    var passwordTitle: String
    
    @State var passwordTitleColor: Color?
    
    @State  var passwordTitleFont: Font?
    
    @State  var passwordTextFieldBorderWidth: Double?
    
    @State var passwordTextFieldBorderColor: Color?
    
    @State var passwordTextFieldCornerRadius: Double?
    
    @State var passwordTextFont: Font?
    
    @State var loginButtonDisabled: Bool = true
    
    // Forgot Password Vars
    
    @State var forgotPasswordButtonTitleColor: Color?
    
    @State var forgotPasswordButtonTitleFont: Font?
    
    // Login Button vars
    
    @State var loginButtonTitleColor: Color?
    
    @State  var loginButtonTitleFont: Font?
    
    @State  var loginButtonBorderWidth: Double?
    
    @State var loginButtonBorderColor: Color?
    
    @State var loginButtonCornerRadius: Double?
    
    @State var loginButtonBackgroundColor: Color?
    
    @Binding var userId: String
    @Binding var password: String
    @State var userIdErrorText: String = ""
    @State var passwordErrorText: String = ""
    var delegate: CustomLoginViewUIProtocol?
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                
                userIdView
                
                HStack{}
                    .frame(height: 20)
                
                passwordView
                
                forgotPasswordButton
                
                loginButton
                
            }
            .padding()
        }
        .onAppear {
            self.setupUI()
        }
    }
    
    /// UserIdTextField View
    var userIdView: some View {
        VStack(alignment: .leading) {
            
            Text(userIdTitle)
                .foregroundColor(self.userIdTitleColor ?? .black)
                .font(self.userIdTitleFont ?? .body)
//                    .fontWeight(self.userIdTitleFontWeight ?? .medium)
            CustomTextField(
                placeholder: "test@example.com",
                text: self.$userId,
                isSecureField: false,
                borderWidth: self.userIdTextFieldBorderWidth ?? 1,
                borderColor: self.userIdTextFieldBorderColor ?? .black,
                cornerRadius: self.userIdTextFieldCornerRadius ?? 8,
                keyboardType: .emailAddress)
            .font(self.userIdTextFont ?? .body)
            .autocorrectionDisabled()
            .onChange(of: self.userId) { newValue in
                self.userIdErrorText = Validation.isValidEmail(email: newValue)
                ? ""
                : "Invalid Email"
            }
            Text(self.userIdErrorText)
                .foregroundColor(.red)
                .font(.caption)
                .padding(.top, -5)
                .padding(.leading, 20)
        }
    }
    
    /// Password TextField View
    var passwordView: some View {
        VStack(alignment: .leading) {
            
            Text(passwordTitle)
                .foregroundColor(self.passwordTitleColor ?? .black)
                .font(self.passwordTitleFont ?? .body)
//                    .fontWeight(self.passwordTextFontWeight ?? .medium)
            CustomTextField(
                placeholder: "************",
                text: self.$password,
                isSecureField: true,
                borderWidth: self.passwordTextFieldBorderWidth ?? 1,
                borderColor: self.passwordTextFieldBorderColor ?? .black,
                cornerRadius: self.passwordTextFieldCornerRadius ?? 8,
                keyboardType: .default)
            .onChange(of: self.userId) { newValue in
                
                self.passwordErrorText = Validation.isValid(password: newValue)
                ? ""
                : "Invalid Password"
            }
            .autocorrectionDisabled()
            Text(self.passwordErrorText)
                .foregroundColor(.red)
                .font(.caption)
                .padding(.top, -5)
                .padding(.leading, 20)
        }
    }
    
    /// Login Button
    var loginButton: some View {
        
        HStack {
            
            Spacer()
            CustomButton(action: loginAction,
                         buttonTitle: "Login",
                         backgroundColor: loginButtonDisabled
                         ? .gray
                         : .mint,
                         borderWidth: 2,
                         borderColor: loginButtonDisabled
                         ? .white
                         : .yellow,
                         cornerRadius: 8)
            .frame(width: 108, height: 44)
            .foregroundColor(.white)
            .font(.subheadline)
            .fontWeight(.heavy)
            .transaction { transaction in
                transaction.animation = .easeInOut(duration: 0.1)
            }
            .disabled(self.loginButtonDisabled)
            
            Spacer()
        }
        .padding(.top, 40)
    }
    
    /// Forgot Password Button
    var forgotPasswordButton: some View {
        HStack {
            
            Spacer()
            CustomButton(
                action: forgotPasswordAction,
                buttonTitle: "ForgotPassword?")
            .foregroundColor(self.forgotPasswordButtonTitleColor ?? .black)
            .font(self.forgotPasswordButtonTitleFont ?? .caption)
        }
    }
    
    func loginButtonAction() {
        print("Login Button tapped")
    }
}

struct CustomLoginView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoginView(
            loginAction: {},
            forgotPasswordAction: {},
            userIdTitle: "Email",
            userIdPlaceholder: "test@example.com",
            passwordTitle: "Password",
            userId: .constant(""),
            password: .constant(""))
    }
}

extension CustomLoginView {
    func setupUI() {
        // UserId
        self.userIdTitleColor = delegate?.headingTextColorForUserIdTextfield()
        self.userIdTitleFont = delegate?.headingTextFontForUserIdTextfield()
        self.userIdTextFieldBorderWidth = delegate?.borderWidthForUserIdTextfield()
        self.userIdTextFieldBorderColor = delegate?.borderColorForUserIdTextfield()
        self.userIdTextFieldCornerRadius = delegate?.cornerRadiusForUserIdTextfield()
        self.userIdTextFont = delegate?.inputTextFontForUserIdTextfield()
        
        // Password
        self.passwordTitleColor = delegate?.headingTextColorForPasswordTextfield()
        self.passwordTitleFont = delegate?.headingFontForPasswordTextfield()
        self.passwordTextFieldBorderWidth = delegate?.borderWidthForPasswordTextfield()
        self.passwordTextFieldBorderColor = delegate?.borderColorForPasswordTextfield()
        self.passwordTextFieldCornerRadius = delegate?.cornerRadiusForPasswordTextfield()
        self.passwordTextFont = delegate?.inputTextFontForPasswordTextfield()
        
        // Forgot Password Button
        self.forgotPasswordButtonTitleColor = delegate?.titleColorForForgotPasswordButton()
        self.forgotPasswordButtonTitleFont = delegate?.titleFontForForgotPasswordButton()
        
        // Login Button
        self.loginButtonTitleColor = delegate?.titleColorForLoginButton()
        self.loginButtonTitleFont = delegate?.titleFontForLoginButton()
        self.loginButtonBorderColor = delegate?.borderColorForLoginButton()
        self.loginButtonBackgroundColor = delegate?.backgroundColorForLoginButton()
        self.loginButtonBorderWidth = delegate?.borderWidthForLoginButton()
        self.loginButtonCornerRadius = delegate?.cornerRadiusForLoginButton()
    }
}

extension CustomLoginView {
    
    var phoneView: some View {
        VStack {
            
        }
    }
}
