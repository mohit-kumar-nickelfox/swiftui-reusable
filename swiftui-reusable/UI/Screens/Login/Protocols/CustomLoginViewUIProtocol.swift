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
    func headingTextColorForUserIdTextfield() -> Color
    
    /// Font for UserId Heading
    /// - Returns: SwiftUI Font
    func headingTextFontForUserIdTextfield() -> Font
    
    /// Border Width for UserId Textfield
    /// - Returns: Border Width
    func borderWidthForUserIdTextfield() -> Double
    
    /// Border Color for UserId Textfield
    /// - Returns: Border Color
    func borderColorForUserIdTextfield() -> Color
    
    /// Corner Radius for UserId Textfield
    /// - Returns: Corner Radius
    func cornerRadiusForUserIdTextfield() -> Double
    
    /// Input Text Font for UserId Textfield
    /// - Returns: Font
    func inputTextFontForUserIdTextfield() -> Font
    
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
    func headingFontForPasswordTextfield() -> Font
    
    /// Border Width for Password Textfield
    /// - Returns: Border Width
    func borderWidthForPasswordTextfield() -> Double
    
    /// Border Color for Password Textfield
    /// - Returns: Border Color
    func borderColorForPasswordTextfield() -> Color
    
    /// Corner Radius for Password Textfield
    /// - Returns: Corner Radius
    func cornerRadiusForPasswordTextfield() -> Double
    
    /// Input Text Font for Password Textfield
    /// - Returns: Font
    func inputTextFontForPasswordTextfield() -> Font
    
//    /// Input Text Font Weight for Password Textfield
//    /// - Returns: Font Weight
//    func inputTextFontWeightForPassword() -> Font.Weight
    
    //--------------------------------------------------------------------------------------
    // Phone Textfield
    
    /// Color for UserId Heading
    /// - Returns: SwiftUI Color
    func headingTextColorForPhoneTextfield() -> Color
    
    /// Font for UserId Heading
    /// - Returns: SwiftUI Font
    func headingTextFontForPhoneTextfield() -> Font
    
    /// Border Width for UserId Textfield
    /// - Returns: Border Width
    func borderWidthForPhoneTextfield() -> Double
    
    /// Border Color for UserId Textfield
    /// - Returns: Border Color
    func borderColorForPhoneTextfield() -> Color
    
    /// Corner Radius for UserId Textfield
    /// - Returns: Corner Radius
    func cornerRadiusForPhoneTextfield() -> Double
    
    /// Input Text Font for UserId Textfield
    /// - Returns: Font
    func inputTextFontForPhoneTextfield() -> Font
    
    
    //------------------------------------------------------------------------------------------
    // Forgot Password
    
    /// Title Color for Forgot Password Button
    /// - Returns: Text Color
    func titleColorForForgotPasswordButton() -> Color
    
    /// Title Font for Forgot Password Button
    /// - Returns: Font
    func titleFontForForgotPasswordButton() -> Font
    
    
    //------------------------------------------------------------------------------------------
    // Login Button
    
    /// Title Color for Login Button
    /// - Returns: Text Color
    func titleColorForLoginButton() -> Color
    
    /// Title Font for Forgot Password Button
    /// - Returns: Font
    func titleFontForLoginButton() -> Font
    
    /// Background Color for Login Button
    /// - Returns: Background Color
    func backgroundColorForLoginButton() -> Color
    
    /// Border Width for Login Button
    /// - Returns: Border Width
    func borderWidthForLoginButton() -> Double
    
    /// Border Color for Login Button
    /// - Returns: Border Color
    func borderColorForLoginButton() -> Color
    
    /// Corner Radius for Login Button
    /// - Returns: Corner Radius
    func cornerRadiusForLoginButton() -> Double
    
}

// MARK: CustomLoginViewModelProtocol
public protocol CustomLoginViewModelProtocol {
    func didTapLoginButtonWith(userId: String, andPassword password: String)
    
    func didTapSendOTPButton(withPhone phone: String)
    
    func loggedInSuccessFully()
    
    func didFailToLogin(withError errorMessage: String)
    
    func didTapForgotPasswordButton(withPhone phone: String)
    
    func didTapForgotPasswordButton(witEmail email: String)
    
    func didTapVerify(otp: String)
}
