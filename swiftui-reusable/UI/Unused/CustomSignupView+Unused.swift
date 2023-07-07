//
//  CustomSignupView+Unused.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

extension CustomSignupView {
    // MARK: Name Textfield
    var nameTextfieldView: some View {
        VStack {
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: "John Doe",
                    text: self.$name,
                    isSecureField: false,
                    title: .constant("Name"),
                    titleColor: self.$textfieldTitleColor,
                    titleFont: self.$textfieldTitleFont,
                    textColor: self.$textfieldTextColor,
                    textFont: self.$textfieldTextFont,
                    errorText: self.$nameErrorText,
                    borderWidth: self.$textfieldBorderWidth,
                    borderColor: self.$textfieldBorderColor,
                    cornerRadius: self.$textfieldCornerRadius,
                    keyboardType: .namePhonePad,
                    onEditingChanged: {if $0 { self.kGuardian.showField = 0 } })
                .background(GeometryGetter(rect: $kGuardian.rects[0]))
                .focused($focusedField, equals: .name)
                .font(self.textfieldTextFont)
                .autocorrectionDisabled()
                .onChange(of: self.name) { newValue in
                    self.viewModel.signupName = newValue
                    self.nameErrorText = !newValue.isEmpty
                    ? ""
                    : "Name cannot be empty"
                    self.signupButtonDisabled = newValue.isEmpty
                }
                .textContentType(.name)
            }
        }
    }
    
    // MARK: Phone Textfield
    var phoneTextfieldView: some View {
        VStack {
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: "987654321",
                    text: self.$phone,
                    isSecureField: false,
                    title: .constant("Phone"),
                    titleColor: self.$textfieldTitleColor,
                    titleFont: self.$textfieldTitleFont,
                    textColor: self.$textfieldTextColor,
                    textFont: self.$textfieldTextFont,
                    errorText: self.$nameErrorText,
                    borderWidth: self.$textfieldBorderWidth,
                    borderColor: self.$textfieldBorderColor,
                    cornerRadius: self.$textfieldCornerRadius,
                    keyboardType: .phonePad,
                    onEditingChanged: { if $0 { self.kGuardian.showField = 1 } })
                .background(GeometryGetter(rect: $kGuardian.rects[1]))
                .textContentType(.telephoneNumber)
                .focused($focusedField, equals: .phone)
                .font(self.textfieldTextFont)
                .autocorrectionDisabled()
                .onChange(of: self.phone) { newValue in
                    self.viewModel.signupPhone = newValue
                    self.phoneErrorText = newValue.isValidPhone
                    ? ""
                    : "Invalid Email"
                    self.signupButtonDisabled = !newValue.isValidPhone
                    
                    
                }
            }
        }
    }
    
    // MARK: Email Textfield
    var emailTextfieldView: some View {
        VStack {
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: "test@example.com",
                    text: self.$email,
                    isSecureField: false,
                    title: .constant("Email"),
                    titleColor: self.$textfieldTitleColor,
                    titleFont: self.$textfieldTitleFont,
                    textColor: self.$textfieldTextColor,
                    textFont: self.$textfieldTextFont,
                    errorText: self.$nameErrorText,
                    borderWidth: self.$textfieldBorderWidth,
                    borderColor: self.$textfieldBorderColor,
                    cornerRadius: self.$textfieldCornerRadius,
                    keyboardType: .emailAddress,
                    onEditingChanged: { if $0 { self.kGuardian.showField = 2 } })
                .background(GeometryGetter(rect: $kGuardian.rects[2]))
                .focused($focusedField, equals: .email)
                .font(self.textfieldTextFont)
                .autocorrectionDisabled()
                .onChange(of: self.email) { newValue in
                    self.viewModel.signupEmail = newValue
                    self.emailErrorText = newValue.isValidEmail
                    ? ""
                    : "Invalid Phone number"
                    self.signupButtonDisabled = !newValue.isValidEmail
                    
                    print(newValue.isValidPhone)
                    
                    
                }
            }
        }
    }
    
    // MARK: Password TextField
    var passwordView: some View {
        VStack(alignment: .leading) {
            CustomTextField(
                placeholder: "************",
                text: self.$password,
                isSecureField: true,
                title: .constant("Password"),
                titleColor: self.$textfieldTitleColor,
                titleFont: self.$textfieldTitleFont,
                textColor: self.$textfieldTextColor,
                textFont: self.$textfieldTextFont,
                errorText: self.$nameErrorText,
                borderWidth: self.$textfieldBorderWidth,
                borderColor: self.$textfieldBorderColor,
                cornerRadius: self.$textfieldCornerRadius,
                keyboardType: .emailAddress,
                onEditingChanged: { if $0 { self.kGuardian.showField = 3 } })
            .background(GeometryGetter(rect: $kGuardian.rects[3]))
            .focused($focusedField, equals: .password)
            .textContentType(.password)
            .onChange(of: self.password) { newValue in
                self.viewModel.signupPassword = newValue
                self.passwordErrorText = Validation.isValid(password: newValue)
                ? ""
                : "Invalid Password"
            }
            .autocorrectionDisabled()
        }
    }
}
