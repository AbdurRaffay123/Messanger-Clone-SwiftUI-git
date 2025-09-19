//
//  User.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 09/09/2025.
//

import FirebaseFirestoreSwift
import Foundation

struct User: Codable, Hashable, Identifiable{
    
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profileImageURL: String?
    
    var id: String{
        return uid ?? NSUUID().uuidString
    }
    
    var firstName: String{
        let formatter = PersonNameComponentsFormatter()
        let component = formatter.personNameComponents(from: fullname)
        return component?.givenName ?? fullname
    }
}

extension User{
    static let MOCK_USER = User(fullname: "Abdur Raffay", email: "abdurraffay123@gmail.com", profileImageURL: "batman")
}
