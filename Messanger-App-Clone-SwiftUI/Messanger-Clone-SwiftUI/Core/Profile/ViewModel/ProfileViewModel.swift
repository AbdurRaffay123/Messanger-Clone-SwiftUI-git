//
//  ProfileViewModel.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 09/09/2025.
//

import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    @Published var profileImage: Image?
    // Hold all user data
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
}
