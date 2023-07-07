//
//  CustomSignupView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 05/07/23.
//

import SwiftUI
import Combine

public struct CustomSignupView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: CustomLoginViewModel
    
    @State var phone: String = ""
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    
    @Binding var textfieldTitleFont: Font
    @Binding var textfieldTitleColor: Color
    @Binding var textfieldBorderWidth: Double
    @Binding var textfieldBorderColor: Color
    @Binding var textfieldCornerRadius: Double
    @Binding var textfieldTextFont: Font
    @Binding var textfieldTextColor: Color
    
    // Button disable var
    @State var signupButtonDisabled: Bool = true
    
    // Errors
    @State var phoneErrorText: String = ""
    @State var emailErrorText: String = ""
    @State var nameErrorText: String = ""
    @State var passwordErrorText: String = ""
    
    // Textfield Focus
    @FocusState var focusedField: CustomSignupFieldType?
    
    // Image picking
    @State var showImagePicker: Bool = false
    
    // Keyboard management
    @ObservedObject var kGuardian = KeyboardGuardian(textFieldCount: 4)
    
    public var body: some View {
        ScrollView {
            VStack {
                profileImageView
                textFieldsView.padding(.horizontal, 2)
                SignupButton.padding(.horizontal, 2)
                loginButtonView
            }
            
        }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    toolBarView
                }
            }
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3), value: kGuardian.slide)
            .onAppear { self.kGuardian.addObserver() }
            .onDisappear { self.kGuardian.removeObserver() }
    }
}

// MARK: Helper Functions
extension CustomSignupView {
    func binder(forField field: CustomSignupFieldType) -> Binding<String> {
        switch field {
        case .name:
            return self.$name
        case .phone:
            return self.$phone
        case .email:
            return self.$email
        case .password:
            return self.$password
        }
    }
    
    func fieldErrorText(inField field: CustomSignupFieldType) -> String {
        switch field {
        case .name:
            return self.nameErrorText
        case .phone:
            return self.phoneErrorText
        case .email:
            return self.emailErrorText
        case .password:
            return self.passwordErrorText
        }
    }
    
    func fieldErrorTextBinder(inField field: CustomSignupFieldType) -> Binding<String> {
        switch field {
        case .name:
            return self.$nameErrorText
        case .phone:
            return self.$phoneErrorText
        case .email:
            return self.$emailErrorText
        case .password:
            return self.$passwordErrorText
        }
    }
    
    func updateText(forField field: CustomSignupFieldType, withText text: String) {
        switch field {
        case .name:
            self.viewModel.signupName = text
            self.nameErrorText = !text.isEmpty
            ? ""
            : "Name cannot be empty"
        case .email:
            self.viewModel.signupEmail = text
            self.emailErrorText = text.isValidEmail
            ? ""
            : "Invalid Email"
        case .phone:
            self.viewModel.signupPhone = text
            self.phoneErrorText = text.isValidPhone
            ? ""
            : "Invalid Phone"
        case .password:
            self.viewModel.signupPassword = text
            self.passwordErrorText = Validation.isValid(password: text)
            ? ""
            : "Password should be atleast 5 characters long"
        }
    }
    
    func done() {
        switch self.focusedField {
        case .email,
                .name,
                .phone,
                .password:
            self.focusedField = nil
        default: ()
        }
    }
    
    func next() {
        switch self.focusedField {
        case .name: self.focusedField = .phone
        case .phone: self.focusedField = .email
        case .email: self.focusedField = .password
        default: ()
        }
    }
    
    func previous() {
        switch self.focusedField {
        case .name: ()
        case .phone: self.focusedField = .name
        case .email: self.focusedField = .phone
        default: self.focusedField = .email
        }
    }
    
    var isPreviousDisabled: Bool {
        return self.focusedField == .name
    }
    
    var isNextDisabled: Bool {
        return self.focusedField == .password
    }
    
    func didSelectImage(_ image: UIImage) {
        self.viewModel.profileImageData = image.jpegData(compressionQuality: 0.6)
    }
}

// MARK: Preview
struct CustomSignupView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSignupView(
            viewModel: CustomLoginViewModel(),
            textfieldTitleFont: .constant(.body),
            textfieldTitleColor: .constant(.black),
            textfieldBorderWidth: .constant(2),
            textfieldBorderColor: .constant(.black),
            textfieldCornerRadius: .constant(2),
            textfieldTextFont: .constant(.body),
            textfieldTextColor: .constant(.black))
    }
}

