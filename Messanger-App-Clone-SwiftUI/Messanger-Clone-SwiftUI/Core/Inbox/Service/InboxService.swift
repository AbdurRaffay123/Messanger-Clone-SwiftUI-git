//
//  InboxService.swift
//   
//
//  Created by Dev on 17/09/2025.
//

import Foundation
import Firebase

class InboxService {
    @Published var documentChanges = [DocumentChange]()
    
    func observeRecentMessage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants.UserCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timeStamp", descending: true) 
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            self.documentChanges = changes
        }
    }
}
