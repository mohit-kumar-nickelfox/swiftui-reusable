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
                
                Text("Name")
                    .foregroundColor(self.titleColor ?? (self.colorScheme == .light ? .black : .white))
                    .font(self.titleFont ?? .body)
                CustomTextField(
                    placeholder: "John Doe",
                    text: self.$name,
                    isSecureField: false,
                    borderWidth: self.textfieldBorderWidth ?? 1,
                    borderColor: self.phoneErrorText.isEmpty
                    ? self.textfieldBorderColor ?? (
                        self.colorScheme == .light
                        ? .black :
                                .white)
                    : .red,
                    cornerRadius: self.textfieldCornerRadius ?? 8,
                    keyboardType: .namePhonePad,
                    onEditingChanged: {if $0 { self.kGuardian.showField = 0 } })
                .background(GeometryGetter(rect: $kGuardian.rects[0]))
                .focused($focusedField, equals: .name)
                .font(self.textFont ?? .body)
                .autocorrectionDisabled()
                .onChange(of: self.name) { newValue in
                    self.viewModel.signupName = newValue
                    self.nameErrorText = !newValue.isEmpty
                    ? ""
                    : "Name cannot be empty"
                    self.signupButtonDisabled = newValue.isEmpty
                }
                .textContentType(.name)
                Text(self.nameErrorText)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, -5)
                    .padding(.leading, 20)
            }
        }
    }
    
    // MARK: Phone Textfield
    var phoneTextfieldView: some View {
        VStack {
            VStack(alignment: .leading) {
                
                Text("Phone")
                    .foregroundColor(self.titleColor ?? (self.colorScheme == .light ? .black : .white))
                    .font(self.titleFont ?? .body)
                CustomTextField(
                    placeholder: "987654321",
                    text: self.$phone,
                    isSecureField: false,
                    borderWidth: self.textfieldBorderWidth ?? 1,
                    borderColor: self.emailErrorText.isEmpty
                    ? self.textfieldBorderColor ?? (self.colorScheme == .light ? .black : .white)
                    : .red,
                    cornerRadius: self.textfieldCornerRadius ?? 8,
                    keyboardType: .phonePad,
                    onEditingChanged: { if $0 { self.kGuardian.showField = 1 } })
                .background(GeometryGetter(rect: $kGuardian.rects[1]))
                .textContentType(.telephoneNumber)
                .focused($focusedField, equals: .phone)
                .font(self.textFont ?? .body)
                .autocorrectionDisabled()
                .onChange(of: self.phone) { newValue in
                    self.viewModel.signupPhone = newValue
                    self.phoneErrorText = newValue.isValidPhone
                    ? ""
                    : "Invalid Email"
                    self.signupButtonDisabled = !newValue.isValidPhone
                    
                    
                }
                
                Text(self.phoneErrorText)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, -5)
                    .padding(.leading, 20)
            }
        }
    }
    
    // MARK: Email Textfield
    var emailTextfieldView: some View {
        VStack {
            VStack(alignment: .leading) {
                
                Text("Email")
                    .foregroundColor(self.titleColor ?? (self.colorScheme == .light ? .black : .white))
                    .font(self.titleFont ?? .body)
                CustomTextField(
                    placeholder: "test@example.com",
                    text: self.$email,
                    isSecureField: false,
                    borderWidth: self.textfieldBorderWidth ?? 1,
                    borderColor: self.phoneErrorText.isEmpty
                    ? self.textfieldBorderColor ?? (self.colorScheme == .light ? .black : .white)
                    : .red,
                    cornerRadius: self.textfieldCornerRadius ?? 8,
                    keyboardType: .emailAddress,
                    onEditingChanged: { if $0 { self.kGuardian.showField = 2 } })
                .background(GeometryGetter(rect: $kGuardian.rects[2]))
                .focused($focusedField, equals: .email)
                .font(self.textFont ?? .body)
                .autocorrectionDisabled()
                .onChange(of: self.email) { newValue in
                    self.viewModel.signupEmail = newValue
                    self.emailErrorText = newValue.isValidEmail
                    ? ""
                    : "Invalid Phone number"
                    self.signupButtonDisabled = !newValue.isValidEmail
                    
                    print(newValue.isValidPhone)
                    
                    
                }
                .textContentType(.emailAddress)
                Text(self.emailErrorText)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, -5)
                    .padding(.leading, 20)
            }
        }
    }
    
    // MARK: Password TextField
    var passwordView: some View {
        VStack(alignment: .leading) {
            
            Text("Password")
                .foregroundColor(self.titleColor ?? (self.colorScheme == .light ? .black : .white))
                .font(self.titleFont ?? .body)
            CustomTextField(
                placeholder: "************",
                text: self.$password,
                isSecureField: true,
                borderWidth: self.textfieldBorderWidth ?? 1,
                borderColor: self.passwordErrorText.isEmpty
                ? self.textfieldBorderColor ?? (self.colorScheme == .light ? .black : .white)
                : .red,
                cornerRadius: self.textfieldCornerRadius ?? 8,
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
            Text(self.passwordErrorText)
                .foregroundColor(.red)
                .font(.caption)
                .padding(.top, -5)
        }
    }
}
