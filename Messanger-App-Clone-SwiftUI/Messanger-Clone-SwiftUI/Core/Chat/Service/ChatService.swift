//
//  ChatService.swift
//   
//
//  Created by Dev on 17/09/2025.
//

import Foundation
import Firebase

struct ChatService {
    static let messagesCollection = Firestore.firestore().collection("messages")
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
         guard let currentUid = Auth.auth().currentUser?.uid else { return }
         let chatPartnerId = chatPartner.id
         
         // 🔹 Messages go under "messages"
         let currentUserRef = FirestoreConstants.MessageCollection
             .document(currentUid)
             .collection(chatPartnerId)
             .document()
         
         let chatPartnerRef = FirestoreConstants.MessageCollection
             .document(chatPartnerId)
             .collection(currentUid)
         
         // 🔹 Recent messages go under "users/{uid}/recent-messages"
         let recentCurrentUserRef = FirestoreConstants.UserCollection
             .document(currentUid)
             .collection("recent-messages")
             .document(chatPartnerId)
         
         let recentPartnerRef = FirestoreConstants.UserCollection
             .document(chatPartnerId)
             .collection("recent-messages")
             .document(currentUid)
         
         let messageId = currentUserRef.documentID
         
         let message = Message(
             messageId: messageId,
             fromId: currentUid,
             toId: chatPartnerId,
             messageText: messageText,
             timeStamp: Timestamp()
         )
         
         guard let messageData = try? Firestore.Encoder().encode(message) else { return }
         
         // 🔹 Write full conversation
         currentUserRef.setData(messageData)
         chatPartnerRef.document(messageId).setData(messageData)
         
         // 🔹 Update recent messages for both users
         recentCurrentUserRef.setData(messageData)
         recentPartnerRef.setData(messageData)
     }

    
     func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = FirestoreConstants.MessageCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timeStamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where message.isFromCurrrentUser {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
