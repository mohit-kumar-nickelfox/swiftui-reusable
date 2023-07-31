//
//  CustomLoginViewModel.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 03/07/23.
//

import SwiftUI

class CustomLoginViewModel: ObservableObject {
    
    public var delegate: CustomLoginViewModelProtocol?
    
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
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
    
    // Country Code
    @Published var selectedCountryCode: String = "IN"
    @Published var showCountryCodeList: Bool = false
    
    
    public init() {
        
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
    public func didGetOTPLoginResponse(withSuccess: Bool, errorMessage: String?) {
        self.showLoader = false
        if let errorMessage {
            self.errorMessage = errorMessage
            self.showErrorAlert.toggle()
        } else {
            // Navigate in case of success
            print("Login Successful With OTP")
        }
    }
    
    public func didGetEmailLoginResponse(withSuccess: Bool, errorMessage: String?) {
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

extension CustomLoginViewModel {
    func getCountryCodes() {
        let countryCodes = NSLocale.isoCountryCodes
        print(countryCodes)
    }
    
    
    func getSelectedFlag() -> String {
        return String(String.UnicodeScalarView(self.selectedCountryCode.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
          }))
    }
    
    func getFlag(forCountryCode code: String) -> String {
        return String(String.UnicodeScalarView(code.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
          }))
    }
    
    func getCountryPhoneCode(forCountryCode code: String) -> String {
        if let path = Bundle.main.path(forResource: "countryCodes", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, String>{
                            return jsonResult[code] ?? "+91"
                  }
              } catch {
                   // handle error
                  print("Error in getting Country phone code", error.localizedDescription)
              }
        }
        
        return "+919"
    }
}
