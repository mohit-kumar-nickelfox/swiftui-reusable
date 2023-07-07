//
//  CustomSignupFieldType.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import SwiftUI

// MARK: CustomSignupFieldType
public enum CustomSignupFieldType: String {
    case name = "name"
    case phone = "phone"
    case email = "email"
    case password = "password"
    
    public var defaultTitle: String {
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
    
    public var defaultTitleColorLight: Color {
        return .black
    }
    
    public var defaultTitleColorDark: Color {
        return .white
    }
    
    public var defaultTitleFont: Font {
        return .body
    }
    
    public var defaultPlaceholder: String {
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
    
    public var defaultTextFont: Font {
        return .body
    }
    
    public var isSecureField: Bool {
        switch self {
        case .name, .email, .phone: return false
        case .password: return true
        }
    }
    
    public var defaultBorderWidth: Double {
        return 1
    }
    
    public var defaultBorderColorLight: Color {
        return .black
    }
    
    public var defaultBorderColorDark: Color {
        return .white
    }
    
    public var defaultCornerRadius: Double {
        return 8
    }
    
    public var keyboardType: UIKeyboardType {
        switch self {
        case .name:
            return .namePhonePad
        case .phone:
            return .phonePad
        case .email, .password:
            return .emailAddress
        }
    }
    
    public var textContentType: UITextContentType {
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
