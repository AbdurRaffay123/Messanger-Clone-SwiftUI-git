//
//  LoginViewModel.swift
//   
//
//  Created by Dev on 10/09/2025.
//


import SwiftUI

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
