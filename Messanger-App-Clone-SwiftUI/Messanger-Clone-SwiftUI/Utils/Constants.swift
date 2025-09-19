//
//  Constants.swift
//   
//
//  Created by Dev on 17/09/2025.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessageCollection = Firestore.firestore().collection("messages")
}
