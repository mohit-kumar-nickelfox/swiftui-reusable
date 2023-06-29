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
    
    var forgotPasswordAction: (()->Void)?
    
    var signupAction: (()->Void)?
    
    // UserId vars
    
    /// User Id Textfiled title
    var userIdTitle: String
    
    var userIdTitleColor: Color?
    
    var userIdTitleFont: Font?
    
    var userIdTextFieldBorderWidth: Double?
    
    var userIdTextFieldBorderColor: Color?
    
    var userIdTextFieldCornerRadius: Double?
    
    var userIdTextFont: Font?
    
    var userIdTextFontWeight: Font.Weight?
    
    /// User Id Textfiled placeholder
    var userIdPlaceholder: String
    
    // Password vars
    
    /// Password Textfiled title
    var passwordTitle: String
    
    var passwordTitleColor: Color?
    
    var passwordTitleFont: Font?
    
    var passwordTextFieldBorderWidth: Double?
    
    var passwordTextFieldBorderColor: Color?
    
    var passwordTextFieldCornerRadius: Double?
    
    var passwordTextFontWeight: Font.Weight?
    
    var passwordTextFont: Font?
    
    @State var loginButtonDisabled: Bool = true
    
    @Binding var userId: String
    @Binding var password: String
    @State var userIdErrorText: String = ""
    @State var passwordErrorText: String = ""
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                
                /// UserIdTextField View
                Text(userIdTitle)
                    .foregroundColor(self.userIdTitleColor ?? .black)
                    .font(self.userIdTitleFont ?? .body)
                    .fontWeight(self.userIdTextFontWeight ?? .medium)
                CustomTextField(
                    placeholder: "test@example.com",
                    text: self.$userId,
                    isSecureField: false,
                    borderWidth: self.userIdTextFieldBorderWidth ?? 1,
                    borderColor: self.userIdTextFieldBorderColor ?? .black,
                    cornerRadius: self.userIdTextFieldCornerRadius ?? 8,
                    keyboardType: .emailAddress)
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
                
                HStack{}
                    .frame(height: 20)
                
                /// Password TextField View
                Text(passwordTitle)
                    .foregroundColor(self.passwordTitleColor ?? .black)
                    .font(self.passwordTitleFont ?? .body)
                    .fontWeight(self.passwordTextFontWeight ?? .medium)
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
                
                /// Login Button
                HStack {
                    
                    Spacer()
                    CustomButton(action: loginButtonAction,
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
            .padding()
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
            userIdTitle: "Email",
            userIdPlaceholder: "test@example.com",
            passwordTitle: "Password",
            userId: .constant(""),
            password: .constant(""))
    }
}
