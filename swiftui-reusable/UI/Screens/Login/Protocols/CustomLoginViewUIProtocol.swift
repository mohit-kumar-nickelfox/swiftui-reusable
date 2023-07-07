//
//  CustomLoginViewUIProtocol.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 03/07/23.
//

import SwiftUI

// MARK: CustomLoginViewUIProtocol
public protocol CustomLoginViewUIProtocol {
    
    //--------------------------------------------------------------------------------------
    // UserID Textfield
    
    /// Color for UserId Heading
    /// - Returns: SwiftUI Color
    func headingTextColorForUserIdTextfield() -> Color // Optional
    
    /// Font for UserId Heading
    /// - Returns: SwiftUI Font
    func headingTextFontForUserIdTextfield() -> Font // Optional
    
    /// Border Width for UserId Textfield
    /// - Returns: Border Width
    func borderWidthForUserIdTextfield() -> Double // Optional
    
    /// Border Color for UserId Textfield
    /// - Returns: Border Color
    func borderColorForUserIdTextfield() -> Color
    
    /// Corner Radius for UserId Textfield
    /// - Returns: Corner Radius
    func cornerRadiusForUserIdTextfield() -> Double // Optional
    
    /// Input Text Font for UserId Textfield
    /// - Returns: Font
    func inputTextFontForUserIdTextfield() -> Font // Optional
    
//    /// Input Text Font Weight for UserId Textfield
//    /// - Returns: Font Weight
//    func inputTextFontWeightForUserId() -> Font.Weight
    
    
    //-----------------------------------------------------------------------------------------
    // Password Textfield
    
    /// Color for Password Heading
    /// - Returns: SwiftIUI Color
    func headingTextColorForPasswordTextfield() -> Color
    
    /// Font for Password Heading
    /// - Returns: SwiftUI Font
    func headingFontForPasswordTextfield() -> Font // Optional
    
    /// Border Width for Password Textfield
    /// - Returns: Border Width
    func borderWidthForPasswordTextfield() -> Double // Optional
    
    /// Border Color for Password Textfield
    /// - Returns: Border Color
    func borderColorForPasswordTextfield() -> Color
    
    /// Corner Radius for Password Textfield
    /// - Returns: Corner Radius
    func cornerRadiusForPasswordTextfield() -> Double // Optional
    
    /// Input Text Font for Password Textfield
    /// - Returns: Font
    func inputTextFontForPasswordTextfield() -> Font // Optional
    
//    /// Input Text Font Weight for Password Textfield
//    /// - Returns: Font Weight
//    func inputTextFontWeightForPassword() -> Font.Weight
    
    //--------------------------------------------------------------------------------------
    // Phone Textfield
    
    /// Color for Phone Textfield Heading
    /// - Returns: SwiftUI Color
    func headingTextColorForPhoneTextfield() -> Color
    
    /// Font for Phone Textfield Heading
    /// - Returns: SwiftUI Font
    func headingTextFontForPhoneTextfield() -> Font // Optional
    
    /// Border Width for Phone Textfield
    /// - Returns: Border Width
    func borderWidthForPhoneTextfield() -> Double // Optional
    
    /// Border Color for Phone Textfield
    /// - Returns: Border Color
    func borderColorForPhoneTextfield() -> Color
    
    /// Corner Radius for Phone Textfield
    /// - Returns: Corner Radius
    func cornerRadiusForPhoneTextfield() -> Double // Optional
    
    /// Input Text Font for Phone Textfield
    /// - Returns: Font
    func inputTextFontForPhoneTextfield() -> Font // Optional
    
    
    //------------------------------------------------------------------------------------------
    // Forgot Password
    
    /// Title Color for Forgot Password Button
    /// - Returns: Text Color
    func titleColorForForgotPasswordButton() -> Color
    
    /// Title Font for Forgot Password Button
    /// - Returns: Font
    func titleFontForForgotPasswordButton() -> Font // Optional
    
    
    //------------------------------------------------------------------------------------------
    // Login Button
    
    /// Title Color for Login Button
    /// - Returns: Text Color
    func titleColorForLoginButton() -> Color
    
    /// Title Font for Login Button
    /// - Returns: Font
    func titleFontForLoginButton() -> Font // Optional
    
    /// Background Color for Login Button
    /// - Returns: Background Color
    func backgroundColorForLoginButton() -> Color
    
    /// Border Width for Login Button
    /// - Returns: Border Width
    func borderWidthForLoginButton() -> Double // Optional
    
    /// Border Color for Login Button
    /// - Returns: Border Color
    func borderColorForLoginButton() -> Color // Optional
    
    /// Corner Radius for Login Button
    /// - Returns: Corner Radius
    func cornerRadiusForLoginButton() -> Double
    
}

// MARK: CustomLoginViewModelProtocol
public protocol CustomLoginViewModelProtocol {
    /// Callback for login button tapped
    /// - Parameters:
    ///   - userId: Email
    ///   - password: Password
    func didTapLoginButtonWith(userId: String, andPassword password: String)
    
    /// Callback for getting OTP API
    /// - Parameter phone: Phone number
    func didTapSendOTPButton(withPhone phone: String)
    
    // TODO: Need thought
    func loggedInSuccessFully()
    
    // TODO: Might not need this one
    func didFailToLogin(withError errorMessage: String)
    
    // TODO: Might not need this one
    func didTapForgotPasswordButton(withPhone phone: String)
    
    /// Callback for frogot password button tapped
    /// - Parameter email: Email
    func didTapForgotPasswordButton(witEmail email: String)
    
    /// Verify OTP callback when OTP is filled
    /// - Parameter otp: OTP
    func didTapVerify(otp: String)
}

// MARK: CustomLoginViewUIProtocol Optional Functions
/// Optional Protocol Implementation
/// These protocols can be used on need basis
extension CustomLoginViewUIProtocol {
    
    /// Color for UserId Heading
    /// - Returns: SwiftUI Color
    public func headingTextColorForUserIdTextfield() -> Color {
        return .black
    }
    
    /// Corner Radius for UserId Textfield
    /// - Returns: Corner Radius
    public func cornerRadiusForUserIdTextfield() -> Double {
        return 10
    }
    
    /// Input Text Font for UserId Textfield
    /// - Returns: Font
    public func inputTextFontForUserIdTextfield() -> Font {
        return .body
    }
    
    /// Font for UserId Heading
    /// - Returns: SwiftUI Font
    public func headingTextFontForUserIdTextfield() -> Font {
        return .subheadline
    }
    
    /// Font for Password Heading
    /// - Returns: SwiftUI Font
    public func headingFontForPasswordTextfield() -> Font {
        return .subheadline
    }
    
    /// Corner Radius for Password Textfield
    /// - Returns: Corner Radius
    public func cornerRadiusForPasswordTextfield() -> Double {
        return 10
    }
    
    /// Input Text Font for Password Textfield
    /// - Returns: Font
    public func inputTextFontForPasswordTextfield() -> Font {
        return .body
    }
    
    /// Border Width for UserId Textfield
    /// - Returns: Border Width
    public func borderWidthForUserIdTextfield() -> Double {
        return 1
    }
    
    /// Title Font for Forgot Password Button
    /// - Returns: Font
    public func titleFontForForgotPasswordButton() -> Font {
        return .caption
    }
    
    /// Border Width for Password Textfield
    /// - Returns: Border Width
    public func borderWidthForPasswordTextfield() -> Double {
        return 1
    }
    
    /// Font for Phone Textfield
    /// - Returns: SwiftUI Font
    public func headingTextFontForPhoneTextfield() -> Font {
        return .subheadline
    }
    
    /// Border Width for Phone Textfield
    /// - Returns: Border Width
    public func borderWidthForPhoneTextfield() -> Double {
        return 1
    }
    
    /// Corner Radius for Phone Textfield
    /// - Returns: Corner Radius
    public func cornerRadiusForPhoneTextfield() -> Double {
        return 10
    }
    
    /// Input Text Font for Phone Textfield
    /// - Returns: Font
    public func inputTextFontForPhoneTextfield() -> Font {
        return .body
    }
    
    /// Title Font for Login Button
    /// - Returns: Font
    public func titleFontForLoginButton() -> Font {
        return .subheadline
    }
    
    /// Border Width for Login Button
    /// - Returns: Border Width
    public func borderWidthForLoginButton() -> Double {
        return 0
    }
    
    /// Border Color for Login Button
    /// - Returns: Border Color
    public func borderColorForLoginButton() -> Color {
        return .white
    }
}
