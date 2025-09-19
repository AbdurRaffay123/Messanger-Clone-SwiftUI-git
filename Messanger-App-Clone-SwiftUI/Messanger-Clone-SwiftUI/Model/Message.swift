//
//  Message.swift
//   
//
//  Created by Dev on 11/09/2025.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable, Hashable {
    
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let timeStamp: Timestamp
    
    var user: User?
    
    var id: String{
        return messageId ?? NSUUID().uuidString
    }
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId :  fromId
    }
    var isFromCurrrentUser: Bool{
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timeStampString: String {
        return timeStamp.dateValue().timeStampString()
    }
}
