//
//  CircularProfileImageView.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 09/09/2025.
//

import SwiftUI

enum ProfileImageSize{
    case xxSmall
    case xsmall
    case small
    case medium
    case large
    case xLargee
    
    var dimesions: CGFloat{
        switch self{
            case .xxSmall: return 28
            case .xsmall: return 32
            case .small: return 40
            case .medium: return 56
            case .large: return 64
            case .xLargee: return 80
        }
    }
}

struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageURL{
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimesions, height: size.dimesions)
                .clipShape(Circle())
        }
        else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimesions, height: size.dimesions)
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USER, size: .medium)
}
