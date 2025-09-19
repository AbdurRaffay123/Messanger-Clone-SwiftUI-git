//
//  InboxViewModel.swift
//
//

import Foundation
import Combine
import Firebase

@MainActor
class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()   // always unique per chatPartnerId
    
    private var cancellable = Set<AnyCancellable>()
    private var service = InboxService()
    
    init() {
        setupSubscriber()
        service.observeRecentMessage()
    }
    
    private func setupSubscriber() {
        // keep track of logged in user
        UserService.shared.$currentUser
            .sink { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &cancellable)
        
        // listen for document changes
        service.$documentChanges
            .sink { [weak self] changes in
                self?.handleChanges(changes)
            }
            .store(in: &cancellable)
    }
    
    private func handleChanges(_ changes: [DocumentChange]) {
        for change in changes {
            guard var message = try? change.document.data(as: Message.self) else { continue }
            
            // fetch user for each chatPartner
            UserService.fetchUser(withUid: message.chatPartnerId) { [weak self] user in
                guard let self else { return }
                message.user = user
                
                // ✅ Remove old entry if exists
                if let index = self.recentMessages.firstIndex(where: { $0.chatPartnerId == message.chatPartnerId }) {
                    self.recentMessages.remove(at: index)
                }
                
                // ✅ Insert new message at top
                self.recentMessages.insert(message, at: 0)
            }
        }
    }
}
