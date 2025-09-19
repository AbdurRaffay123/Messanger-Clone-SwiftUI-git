//
//  ChatView.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 09/09/2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    var user: User
    
    init( user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        //header 
        VStack {
            ScrollView{
                VStack{
                    CircularProfileImageView(user: user, size: .xLargee)
                    VStack(spacing: 4){
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messanger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                    }
                }
                // messagess
                
                ForEach(viewModel.messages){ message in
                    ChatMessageCell(message: message)
                }
            }
            
            //message-input
            
            ZStack(alignment: .trailing){
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    viewModel.sendMessage()
                    viewModel.messageText = "" 
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
