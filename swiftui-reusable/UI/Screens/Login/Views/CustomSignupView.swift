//
//  CustomSignupView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 05/07/23.
//

import SwiftUI

public struct CustomSignupView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: CustomLoginViewModel
    
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
    @FocusState var focusedField: ActiveSignupTextfield?
    
    // Image picking
    @State var showImagePicker: Bool = false
    
    public var body: some View {
        ScrollView {
            profileImageView
            nameTextfieldView.padding(.horizontal, 2)
            phoneTextfieldView.padding(.horizontal, 2)
            emailTextfieldView.padding(.horizontal, 2)
            passwordView.padding(.horizontal, 2)
            SignupButton.padding(.horizontal, 2)
            loginButtonView
        }.padding(20)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    toolBarView
                }
            }
    }
}

// MARK: Helper Functions
extension CustomSignupView {
    
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
