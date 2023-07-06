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
    
//    var textfieldTypes: [CustomSignupFieldType] = [.name, .email, .phone, .password]
    
    @State var phone: String = ""
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    
    @State var titleFont: Font?
    @State var titleColor: Color?
    @State var textfieldBorderWidth: Double?
    @State var textfieldBorderColor: Color?
    @State var textfieldCornerRadius: Double?
    @State var textFont: Font?
    
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
                textFieldsViews.padding(.horizontal, 2)
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
    
    func updateText(forField field: CustomSignupFieldType, withText text: String) {
        switch field {
        case .name:
            self.viewModel.signupName = text
            self.nameErrorText = !text.isEmpty
            ? ""
            : "Name cannot be empty"
            print(text, "In name")
//            self.signupButtonDisabled = text.isEmpty
        case .email:
            self.viewModel.signupEmail = text
            self.emailErrorText = text.isValidEmail
            ? ""
            : "Invalid Email"
            print(text, "In email")
//            self.signupButtonDisabled = text.isEmpty
        case .phone:
            self.viewModel.signupPhone = text
            self.phoneErrorText = text.isValidPhone
            ? ""
            : "Invalid Phone"
            print(text, "In phone")
//            self.signupButtonDisabled = text.isEmpty
        case .password:
            self.viewModel.signupPassword = text
            self.passwordErrorText = Validation.isValid(password: text)
            ? ""
            : "Password should be atleast 5 characters long"
            print(text, "In password")
//            self.signupButtonDisabled = text.isEmpty
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
            viewModel: CustomLoginViewModel())
    }
}

// MARK: CustomSignupFieldType
public enum CustomSignupFieldType: String {
    case name = "name"
    case phone = "phone"
    case email = "email"
    case password = "password"
    
    var defaultTitle: String {
        switch self {
        case .name:
            return "Name"
        case .phone:
            return "Phone"
        case .email:
            return "Email"
        case .password:
            return "Password"
        }
    }
    
    var defaultTitleColorLight: Color {
        return .black
    }
    
    var defaultTitleColorDark: Color {
        return .white
    }
    
    var defaultTitleFont: Font {
        return .body
    }
    
    var defaultPlaceholder: String {
        switch self {
        case .name:
            return "Enter your name"
        case .phone:
            return "+01234567890"
        case .email:
            return "xyz@example.com"
        case .password:
            return "********"
        }
    }
    
    var defaultTextFont: Font {
        return .body
    }
    
    var isSecureField: Bool {
        switch self {
        case .name, .email, .phone: return false
        case .password: return true
        }
    }
    
    var defaultBorderWidth: Double {
        return 1
    }
    
    var defaultBorderColorLight: Color {
        return .black
    }
    
    var defaultBorderColorDark: Color {
        return .white
    }
    
    var defaultCornerRadius: Double {
        return 8
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name:
            return .namePhonePad
        case .phone:
            return .phonePad
        case .email, .password:
            return .emailAddress
        }
    }
    
    var textContentType: UITextContentType {
        switch self {
        case .name:
            return .name
        case .phone:
            return .telephoneNumber
        case .email:
            return .emailAddress
        case .password:
            return .newPassword
        }
    }
}

