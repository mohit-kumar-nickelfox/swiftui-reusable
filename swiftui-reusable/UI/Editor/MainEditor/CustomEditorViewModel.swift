//
//  CustomEditorViewModel.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 06/07/23.
//

import Foundation

class CustomEditorViewModel: ObservableObject {
    @Published var customLoginViewModel = CustomLoginViewModel()
    
    @Published var allScreens: [CustomScreen] = [.login, .signup, .loader]
    @Published var selectedScreen: CustomScreen = .login
    @Published var selectedComponent: CustomComponents = .none
    
    init() {}
}
