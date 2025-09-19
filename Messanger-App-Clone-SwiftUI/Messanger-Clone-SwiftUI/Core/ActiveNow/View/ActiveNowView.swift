//
//  ActiveNowView.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 09/09/2025.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 32){
                    ForEach(viewModel.users){ user in
                        NavigationLink(value: Route.chatView(user)){
                            VStack{
                                CircularProfileImageView(user: user, size: .medium)
                                
                                Text(user.firstName)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            } 
                        }
                    }
            }
            .padding()
        }
        .frame(height: 106)
    }
}

#Preview {
    ActiveNowView()
}
