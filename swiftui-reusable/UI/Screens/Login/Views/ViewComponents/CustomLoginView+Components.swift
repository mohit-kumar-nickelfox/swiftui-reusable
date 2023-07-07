//
//  CustomLoginView+Components.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 05/07/23.
//

import SwiftUI

extension CustomLoginView {
    
    // MARK: Signup View
    var signupView: some View {
        CustomSignupView(
            viewModel: CustomLoginViewModel(),
            textfieldTitleFont: self.$textfieldTitleFont,
            textfieldTitleColor: self.$textfieldTitleColor,
            textfieldBorderWidth: self.$textfieldBorderWidth,
            textfieldBorderColor: self.$textfieldBorderColor,
            textfieldCornerRadius: self.$textfieldCornerRadius,
            textfieldTextFont: self.$textfieldTextFont,
            textfieldTextColor: self.$textfieldTextColor)
    }
    
    // MARK: Login View
    var loginView: some View {
        VStack(alignment: .leading) {
            
            // Segmented UI
            SegmentedLoginView(selectedSegment: self.$viewModel.loginType,
                               color: .blue)
            
            HStack{}.frame(height: 20)
            
            if self.showEmailView {
                emailView
                    .frame(width: UIScreen.main.bounds.width - 40)
                
                if self.viewModel.isSignupRequired {
                    signupButtonView
                }
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
                    isLoading: self.$viewModel.showLoader,
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
                CustomTextField(
                    placeholder: "987654321",
                    text: self.$phone,
                    isSecureField: false,
                    title: self.$phoneTitle,
                    titleColor: self.$textfieldTitleColor,
                    titleFont: self.$textfieldTitleFont,
                    textColor: self.$textfieldTextColor,
                    textFont: self.$textfieldTextFont,
                    errorText: self.$phoneErrorText,
                    borderWidth: self.$textfieldBorderWidth,
                    borderColor: self.$textfieldBorderColor,
                    cornerRadius: self.$textfieldCornerRadius,
                    keyboardType: .phonePad)
                .focused(self.$phoneNumberFieldFocused)
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
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Button("Cancel") {
                                phoneNumberFieldFocused = false
                            }.frame(width: 60)
                                .padding(.leading, 10)
                            
                            
                            Spacer()
                            Button("Done") {
                                phoneNumberFieldFocused = false
                            }.frame(width: 60)
                                .padding(.trailing, 10)
                        }.frame(width: UIScreen.main.bounds.size.width)
                    }
                }
                .textContentType(.telephoneNumber)
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
            CustomTextField(
                placeholder: "test@example.com",
                text: self.$userId,
                isSecureField: false,
                title: self.$userIdTitle,
                titleColor: self.$textfieldTitleColor,
                titleFont: self.$textfieldTitleFont,
                textColor: self.$textfieldTextColor,
                textFont: self.$textfieldTextFont,
                errorText: self.$userIdErrorText,
                borderWidth: self.$textfieldBorderWidth,
                borderColor: self.$textfieldBorderColor,
                cornerRadius: self.$textfieldCornerRadius,
                keyboardType: .emailAddress)
            //            .textContentType(.emailAddress)
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
        }
    }
    
    // MARK: Password TextField View
    var passwordView: some View {
        VStack(alignment: .leading) {
            CustomTextField(
                placeholder: "************",
                text: self.$password,
                isSecureField: true,
                title: self.$passwordTitle,
                titleColor: self.$textfieldTitleColor,
                titleFont: self.$textfieldTitleFont,
                textColor: self.$textfieldTextColor,
                textFont: self.$textfieldTextFont,
                errorText: self.$passwordErrorText,
                borderWidth: self.$textfieldBorderWidth,
                borderColor: self.$textfieldBorderColor,
                cornerRadius: self.$textfieldCornerRadius,
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
            LoaderButton(isAnimating: self.$viewModel.showLoader,
                         loaderType: .constant(.classic),
                         action: self.viewModel.loginWithEmail,
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
            .foregroundColor(self.forgotPasswordButtonTitleColor ?? (
                self.colorScheme == .light
                ? .black
                :.white)
            )
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
    
    var signupButtonView: some View {
        HStack {
            Text("Don't have an account?")
            
            CustomButton(
                action: self.viewModel.toggleSignupView,
                buttonTitle: "Signup")
        }
    }
}

// MARK: Preview
struct CustomLoginViewComponents_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoginView(
            viewModel: CustomLoginViewModel(),
            loginAction: {},
            forgotPasswordAction: {},
            userIdTitle: "Email",
            userIdPlaceholder: "test@example.com",
            passwordTitle: "Password",
            phoneTitle: "Phone",
            textfieldTitleColor: .constant(.black),
            textfieldTitleFont: .constant(.body),
            textfieldBorderWidth: .constant(2),
            textfieldBorderColor: .constant(.black),
            textfieldCornerRadius: .constant(8),
            textfieldTextFont: .constant(.body),
            textfieldTextColor: .constant(.black),
            userId: .constant(""),
            password: .constant(""),
            phone: .constant(""))
    }
}
