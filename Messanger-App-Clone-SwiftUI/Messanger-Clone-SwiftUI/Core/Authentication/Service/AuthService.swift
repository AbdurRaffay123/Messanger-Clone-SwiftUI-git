//
//  AuthSevice.swift
//   
//
//  Created by Dev on 10/09/2025.
//

import SwiftUI
import Firebase

class AuthService {
    
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        loadCurrentUserData()
        print("DEBUG: user Logged-In \(userSession?.uid)")
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
        } catch {
            print("DEBUG: Errorr while creating User \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(fullname: String, withEmail email: String, password: String) async throws {
        do{             
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            loadCurrentUserData()
        } catch{
            print("DEBUG: Errorr while creating User \(error.localizedDescription)")
        }
    }
    
   // @MainActor
    func signOut(){
        do{
            try Auth.auth().signOut() // SignOut from the backend.
            self.userSession = nil  // Updates Routing Logic
            UserService.shared.currentUser = nil
        }
        catch{
            print("DEBUG: Erorr whilee Signing  Out \(error.localizedDescription)")
        }
    }
     
   // @MainActor
    private func uploadUserData(email: String, fullname: String, id: String) async throws {
        let user = User(fullname: fullname, email: email, profileImageURL: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
    
    private func loadCurrentUserData(){
        Task { try await UserService.shared.fetchCurrentUser()  }
    }
}
