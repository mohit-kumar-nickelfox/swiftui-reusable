//
//  CustomLoginView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import SwiftUI

// TODO: font and color for segmented ui

struct CustomLoginView: View {
    
    let animationDuration: Double = 0.5
    
    @ObservedObject var viewModel: CustomLoginViewModel
    
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
    @State var sendOTPButtonDisabled: Bool = true
    
    // Phone vars
    
    /// PhoneTextfiled title
    var phoneTitle: String
    
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
    var delegate: CustomLoginViewUIProtocol?
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                
                // Segmented UI
                SegmentedLoginView(selectedSegment: self.$viewModel.loginType,
                                   color: .blue)
                
                HStack{}.frame(height: 20)
                
                if self.showEmailView {
                    emailView
                        .frame(width: UIScreen.main.bounds.width - 40)
                } else {
                    EmptyView()
                }
                
                if self.showPhoneView {
                    phoneView
                        .frame(width: UIScreen.main.bounds.width - 40)
                }
                
                Spacer()
                
            }
            .frame(height: 450)
            .padding()
            
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
    
    // MARK: Phone  View
    var phoneView: some View {
        VStack {
            
            if self.viewModel.showPhoneField {
                // Show Phone Number field and send otp button
                phoneTextfieldView
                sendOTPButton
            } else {
                // Show OTP View
                PhoneOTPView(
                    phoneNumber: self.viewModel.phoneNumber ?? "",
                    otpFilled: self.otpFilled(_:),
                    getOTPAgain: self.viewModel.getOTP,
                    changePhoneNumber: self.changeNumber
                )
            }
        }
    }
    
    // MARK: Phone Textfield View
    var phoneTextfieldView: some View {
        VStack {
            VStack(alignment: .leading) {
                
                Text(phoneTitle)
                    .foregroundColor(self.phoneTitleColor ?? .black)
                    .font(self.phoneTitleFont ?? .body)
                CustomTextField(
                    placeholder: "987654321",
                    text: self.$phone,
                    isSecureField: false,
                    borderWidth: self.phoneTextFieldBorderWidth ?? 1,
                    borderColor: self.phoneErrorText.isEmpty
                    ? self.phoneTextFieldBorderColor ?? .black
                    : .red,
                    cornerRadius: self.phoneTextFieldCornerRadius ?? 8,
                    keyboardType: .phonePad)
                .font(self.phoneTextFont ?? .body)
                .autocorrectionDisabled()
                .onChange(of: self.phone) { newValue in
                    self.viewModel.phoneNumber = newValue
                    self.phoneErrorText = newValue.isValidPhone
                    ? ""
                    : "Invalid Phone number"
                    self.sendOTPButtonDisabled = !newValue.isValidPhone
                    
                    print(newValue.isValidPhone)
                    
                    
                }
                Text(self.phoneErrorText)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, -5)
                    .padding(.leading, 20)
            }
        }
    }
    
    // MARK: Email View
    var emailView: some View {
        VStack {
            userIdView
            
            HStack{}.frame(height: 20)
            
            passwordView
            
            forgotPasswordButton
            
            loginButton
        }
    }
    
    // MARK: UserIdTextField View
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
                borderColor: self.userIdErrorText.isEmpty
                ? self.phoneTextFieldBorderColor ?? .black
                : .red,
                cornerRadius: self.userIdTextFieldCornerRadius ?? 8,
                keyboardType: .emailAddress)
            .font(self.userIdTextFont ?? .body)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .onChange(of: self.userId) { newValue in
                self.viewModel.userId = newValue
                self.userIdErrorText = Validation.isValidEmail(email: newValue)
                ? ""
                : "Invalid Email"
                self.enableLoginButton()
            }
            Text(self.userIdErrorText)
                .foregroundColor(.red)
                .font(.caption)
                .padding(.top, -5)
                .padding(.leading, 20)
        }
    }
    
    // MARK: Password TextField View
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
                borderColor: self.passwordErrorText.isEmpty
                ? self.phoneTextFieldBorderColor ?? .black
                : .red,
                cornerRadius: self.passwordTextFieldCornerRadius ?? 8,
                keyboardType: .default)
            .onChange(of: self.password) { newValue in
                self.viewModel.password = newValue
                self.passwordErrorText = Validation.isValid(password: newValue)
                ? ""
                : "Invalid Password"
                self.enableLoginButton()
            }
            .autocorrectionDisabled()
            Text(self.passwordErrorText)
                .foregroundColor(.red)
                .font(.caption)
                .padding(.top, -5)
                .padding(.leading, 20)
        }
    }
    
    // MARK: Login Button
    var loginButton: some View {
        
        HStack {
            
            Spacer()
            CustomButton(action: self.viewModel.loginWithEmail,
                         buttonTitle: "Login",
                         backgroundColor: loginButtonDisabled
                         ? .gray
                         : .mint,
                         borderWidth: 2,
                         borderColor: loginButtonDisabled
                         ? .white
                         : .yellow,
                         cornerRadius: 8)
            .frame(width: UIScreen.main.bounds.size.width - 40, height: 44)
            .foregroundColor(.white)
            .font(.subheadline)
            .fontWeight(.heavy)
            .disabled(self.loginButtonDisabled)
            
            Spacer()
        }
        .padding(.top, 40)
    }
    
    // MARK: Forgot Password Button
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
    
    // MARK: Send OTP Button
    var sendOTPButton: some View {
        HStack {
            
            Spacer()
            CustomButton(action: self.viewModel.getOTP,
                         buttonTitle: "Send OTP",
                         backgroundColor: sendOTPButtonDisabled
                         ? .gray
                         : .mint,
                         borderWidth: 2,
                         borderColor: sendOTPButtonDisabled
                         ? .white
                         : .yellow,
                         cornerRadius: 8)
            .frame(width: UIScreen.main.bounds.size.width - 40, height: 44)
            .foregroundColor(.white)
            .font(.subheadline)
            .fontWeight(.heavy)
            .disabled(self.sendOTPButtonDisabled)
            
            Spacer()
        }
        .padding(.top, 40)
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
