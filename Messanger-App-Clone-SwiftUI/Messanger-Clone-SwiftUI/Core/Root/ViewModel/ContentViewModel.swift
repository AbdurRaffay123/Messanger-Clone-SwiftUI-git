//
//  ContentViewModel.swift
//   
//
//  Created by Dev on 10/09/2025.
//

import Firebase
import Combine

class ContentViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        setupSubscribers()
    }
          
  //  @MainActor
    private func setupSubscribers() {
        AuthService.shared.$userSession
            .sink { [weak self] userSessionFromAuthServices in
                self?.userSession = userSessionFromAuthServices
            }
            .store(in: &cancellables)
    }
}
