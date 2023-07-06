//
//  CustomLoginView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import SwiftUI

// TODO: font and color for segmented ui

public struct CustomLoginView: View {
    
    let animationDuration: Double = 0.5
    
    @ObservedObject var viewModel: CustomLoginViewModel
    
    // Actions
    
    public var loginAction: ()->Void
    
    public var forgotPasswordAction: (()->Void)
    
    public var signupAction: (()->Void)?
    
    // UserId vars
    
    /// User Id Textfiled title
    public var userIdTitle: String
    
    @State var userIdTitleColor: Color?
    
    @State var userIdTitleFont: Font?
    
    @State var userIdTextFieldBorderWidth: Double?
    
    @State var userIdTextFieldBorderColor: Color?
    
    @State var userIdTextFieldCornerRadius: Double?
    
    @State var userIdTextFont: Font?
    
    /// User Id Textfiled placeholder
    public var userIdPlaceholder: String
    
    // Password vars
    
    /// Password Textfiled title
    public var passwordTitle: String
    
    @State var passwordTitleColor: Color?
    
    @State  var passwordTitleFont: Font?
    
    @State  var passwordTextFieldBorderWidth: Double?
    
    @State var passwordTextFieldBorderColor: Color?
    
    @State var passwordTextFieldCornerRadius: Double?
    
    @State var passwordTextFont: Font?
    
    @State var loginButtonDisabled: Bool = true
    @State var sendOTPButtonDisabled: Bool = true
    
    // Phone vars
    
    /// PhoneTextfiled title
    public var phoneTitle: String
    
    @State var phoneTitleColor: Color?
    
    @State var phoneTitleFont: Font?
    
    @State var phoneTextFieldBorderWidth: Double?
    
    @State var phoneTextFieldBorderColor: Color?
    
    @State var phoneTextFieldCornerRadius: Double?
    
    @State var phoneTextFont: Font?
    
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
    @Binding var phone: String
    @State var userIdErrorText: String = ""
    @State var passwordErrorText: String = ""
    @State var phoneErrorText: String = ""
    @State var showEmailView: Bool = true
    @State var showPhoneView: Bool = false
    
    // Field Focused
    @FocusState var phoneNumberFieldFocused
    public var delegate: CustomLoginViewUIProtocol?
    public var body: some View {
        
        ZStack {
            
            if self.viewModel.showSignupView {
                signupView
            } else {
                loginView
            }
            
            
                        
            if self.viewModel.showLoader {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .tint(Color.black)
                }
                .allowsHitTesting(true)
            }
            
        }
        .onAppear {
            self.setupUI()
        }
        .onChange(of: self.viewModel.loginType) { newValue in
            self.showEmailView = newValue == .email
            self.showPhoneView = newValue == .phone
        }
        .alert(isPresented: self.$viewModel.showErrorAlert) {
            Alert(title: Text("Error!"), message: Text(self.viewModel.errorMessage ?? ""), dismissButton: .cancel(Text("Okay")))
        }
        .allowsHitTesting(!self.viewModel.showLoader)
    }
    
    
}

// MARK: Helper Functions
extension CustomLoginView {
    
    func loginButtonAction() {
        self.viewModel.loginWithEmail()
    }
    
    func enableLoginButton() {
        self.loginButtonDisabled = !(Validation.isValidEmail(email: self.viewModel.userId ?? "") &&
        Validation.isValid(password: self.viewModel.password ?? ""))
        print(self.loginButtonDisabled)
    }
    
    func otpFilled(_ otp: String) {
        self.viewModel.verify(otp: otp)
    }
    
    func changeNumber() {
        self.viewModel.showPhoneField = true
    }
}

// MARK: UI Setup
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

// MARK: Preview
struct CustomLoginView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoginView(
            viewModel: CustomLoginViewModel(),
            loginAction: {},
            forgotPasswordAction: {},
            userIdTitle: "Email",
            userIdPlaceholder: "test@example.com",
            passwordTitle: "Password",
            phoneTitle: "Phone",
            userId: .constant(""),
            password: .constant(""),
            phone: .constant(""))
    }
}
