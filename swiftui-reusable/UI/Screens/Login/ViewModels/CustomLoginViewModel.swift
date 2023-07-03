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
    
    init() {
        
    }
    
}
