//
//  ActiveNowViewModel.swift
//   
//
//  Created by Dev on 17/09/2025.
//

import Foundation
import Firebase

class ActiveNowViewModel: ObservableObject{
    @Published var users = [User]()
    
    init(){
        Task { try await fetchAllUsers() }
    }

    
    @MainActor
    private func fetchAllUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid  else { return }
        let users = try await UserService.fetchAllUsers(limit: 10)
        self.users = users.filter({ $0.id != currentUid })
    }
}
