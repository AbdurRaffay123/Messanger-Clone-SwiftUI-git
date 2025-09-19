//
//  RegistrationViewModel.swift
//   
//
//  Created by Dev on 10/09/2025.
//

import SwiftUI

class RegistrationViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(fullname: fullname, withEmail: email, password: password)
    }
}
