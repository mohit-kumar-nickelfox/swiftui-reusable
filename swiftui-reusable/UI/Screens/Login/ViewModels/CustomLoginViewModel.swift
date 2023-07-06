//
//  CustomLoginViewModel.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 03/07/23.
//

import SwiftUI

class CustomLoginViewModel: ObservableObject {
    
    var delegate: CustomLoginViewModelProtocol?
    
    @Published var userId: String?
    @Published var password: String?
    @Published var phoneNumber: String?
    @Published var otp: String?
    @Published var loginType: LoginType = .email
    
    @Published var errorMessage: String?
    
    @Published var showLoader: Bool = false
    @Published var showErrorAlert: Bool = false
    
    // Handle Phone View
    @Published var showPhoneField: Bool = true
    
    // Signup
    @Published var isSignupRequired: Bool = true
    @Published var signupPhone: String?
    @Published var signupEmail: String?
    @Published var signupName: String?
    @Published var signupPassword: String?
    @Published var profileImageData: Data?
    @Published var signupInputFields: [CustomSignupFieldType] = [.name, .email, .phone, .password]
    
    // Toggles
    @Published var showSignupView: Bool = false
    
    
    init() {
        
    }
    
    func showOTPView() {
        self.showPhoneField = false
    }
    
    func toggleSignupView() {
        self.showSignupView.toggle()
    }
    
}

// MARK: ViewModel -> Model
extension CustomLoginViewModel {
    func verify(otp: String) {
        self.showLoader = true
        self.delegate?.didTapVerify(otp: otp)
    }
    
    func loginWithEmail() {
        self.showLoader = true
        self.delegate?.didTapLoginButtonWith(userId: self.userId ?? "", andPassword: password ?? "")
    }
    
    func signup() {
        
    }
}

// MARK: View Connected Functions
extension CustomLoginViewModel {
    func getOTP() {
        self.showOTPView()
        self.delegate?.didTapSendOTPButton(withPhone: self.phoneNumber ?? "")
    }
}

// MARK: Model -> ViewModel
extension CustomLoginViewModel {
    func didGetOTPLoginResponse(withSuccess: Bool, errorMessage: String?) {
        self.showLoader = false
        if let errorMessage {
            self.errorMessage = errorMessage
            self.showErrorAlert.toggle()
        } else {
            // Navigate in case of success
            print("Login Successful With OTP")
        }
    }
    
    func didGetEmailLoginResponse(withSuccess: Bool, errorMessage: String?) {
        self.showLoader = false
        if let errorMessage {
            self.errorMessage = errorMessage
            self.showErrorAlert.toggle()
        } else {
            // Navigate in case of success
            print("Login Successful with Email credentials")
        }
    }
}
