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
    
    // MARK: Textfield Views
    var textFieldsView: some View {
        VStack(alignment: .leading) {
            
            ForEach(0..<self.viewModel.signupInputFields.count, id: \.self) { index in
                let field = self.viewModel.signupInputFields[index]
                
                Text(field.defaultTitle)
                    .foregroundColor(
                        self.titleColor ?? (
                            self.colorScheme == .light
                            ? field.defaultTitleColorLight
                            : field.defaultTitleColorDark)
                    )
                    .font(self.titleFont ?? field.defaultTitleFont)
                    .padding(.horizontal, 20)
                
                CustomTextField(
                    placeholder: field.defaultPlaceholder,
                    text: self.binder(forField: field),
                    isSecureField: field.isSecureField,
                    borderWidth: self.textfieldBorderWidth ?? field.defaultBorderWidth,
                    borderColor: self.fieldErrorText(inField: field).isEmpty
                    ? self.textfieldBorderColor ?? (
                        self.colorScheme == .light
                        ? field.defaultTitleColorLight
                        : field.defaultTitleColorDark
                    )
                    : .red,
                    cornerRadius: self.textfieldCornerRadius ?? field.defaultCornerRadius,
                    keyboardType: field.keyboardType,
                    onEditingChanged: {changed in if changed { self.kGuardian.showField = index } })
                .background(GeometryGetter(rect: $kGuardian.rects[index]))
                .focused($focusedField, equals: field)
                .font(self.textFont ?? field.defaultTextFont)
                .autocorrectionDisabled()
                .textContentType(field.textContentType)
                .padding(.horizontal, 20)
                Text(self.fieldErrorText(inField: field))
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, -5)
                    .padding(.leading, 20)
                    .padding(.horizontal, 20)
            }
        }
        .onChange(of: self.name) { newValue in
            self.viewModel.signupName = newValue
            self.nameErrorText = !newValue.isEmpty
            ? ""
            : "Name cannot be empty"
            self.signupButtonDisabled = newValue.isEmpty
        }
        
        .onChange(of: self.phone) { newValue in
            self.viewModel.signupPhone = newValue
            self.phoneErrorText = newValue.isValidPhone
            ? ""
            : "Invalid Phone Number"
            self.signupButtonDisabled = !newValue.isValidPhone
            
            
        }
        
        .onChange(of: self.email) { newValue in
            self.viewModel.signupEmail = newValue
            self.emailErrorText = newValue.isValidEmail
            ? ""
            : "Invalid Email"
            self.signupButtonDisabled = !newValue.isValidEmail
            
            print(newValue.isValidPhone)
            
            
        }
        
        .onChange(of: self.password) { newValue in
            self.viewModel.signupPassword = newValue
            self.passwordErrorText = Validation.isValid(password: newValue)
            ? ""
            : "Password must be atleast 5 characters long"
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

// MARK: Preview
struct CustomSignupView_Components_Previews: PreviewProvider {
    static var previews: some View {
        CustomSignupView(
            viewModel: CustomLoginViewModel())
    }
}
