//
//  CustomSignupView+Components.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 05/07/23.
//

import SwiftUI

enum ActiveSignupTextfield {
    case name, phone, email, password, none
}

extension CustomSignupView {
    
    // MARK: Profile Image View
    var profileImageView: some View {
        ProfileImageView(didSelectImage: didSelectImage(_:))
        
    }
    
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
                    ? self.textfieldBorderColor ?? (self.colorScheme == .light ? .black : .white)
                    : .red,
                    cornerRadius: self.textfieldCornerRadius ?? 8,
                    keyboardType: .namePhonePad)
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
                    keyboardType: .phonePad)
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
                    keyboardType: .emailAddress)
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
//                    .fontWeight(self.passwordTextFontWeight ?? .medium)
            CustomTextField(
                placeholder: "************",
                text: self.$password,
                isSecureField: true,
                borderWidth: self.textfieldBorderWidth ?? 1,
                borderColor: self.passwordErrorText.isEmpty
                ? self.textfieldBorderColor ?? (self.colorScheme == .light ? .black : .white)
                : .red,
                cornerRadius: self.textfieldCornerRadius ?? 8,
                keyboardType: .emailAddress)
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
    
    // MARK: Signup Button
    var SignupButton: some View {
        HStack {
            
            Spacer()
            CustomButton(action: self.viewModel.signup,
                         buttonTitle: "Sign Up",
                         backgroundColor: signupButtonDisabled
                         ? .gray
                         : .mint,
                         borderWidth: 2,
                         borderColor: signupButtonDisabled
                         ? (self.colorScheme == .light ? .white : .black)
                         : .yellow,
                         cornerRadius: 8)
            .frame(width: UIScreen.main.bounds.size.width - 40, height: 44)
            .foregroundColor((self.colorScheme == .light ? .white : .black))
            .font(.subheadline)
            .fontWeight(.heavy)
            .disabled(self.signupButtonDisabled)
            
            Spacer()
        }
        .padding(.top, 40)
    }
    
    // MARK: Login Button View
    var loginButtonView: some View {
        HStack {
            Button {
                self.viewModel.toggleSignupView()
            } label: {
                Text("Go Back to Login")
            }

        }
    }
    
    // MARK: Tool Bar View
    var toolBarView: some View {
        HStack {
            
            Button {
                self.previous()
            } label: {
                Image(systemName: "chevron.left")
                    .tint(self.isPreviousDisabled
                          ? .gray
                          : .blue)
            }
            .disabled(self.isPreviousDisabled)
            
            Button {
                self.next()
            } label: {
                Image(systemName: "chevron.right")
                    .tint(self.isNextDisabled
                          ? .gray
                          : .blue)
            }
            .disabled(self.isNextDisabled)
            
            
            Spacer()
            Button("Done") {
                self.done()
            }.frame(width: 60)
                .padding(.trailing, 10)
        }
    }
}

struct CustomSignupView_Components_Previews: PreviewProvider {
    static var previews: some View {
        CustomSignupView(
            viewModel: CustomLoginViewModel())
    }
}
