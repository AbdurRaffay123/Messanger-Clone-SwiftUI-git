//
//  ChatMessageCell.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 10/09/2025.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: Message
    
    private var isFromCurrrentUser: Bool{
        return message.isFromCurrrentUser
    }
    
    var body: some View {
        HStack{
            if isFromCurrrentUser {
                Spacer()
                
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrrentUser: isFromCurrrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing )
            }
            else{
                HStack(alignment: .bottom, spacing: 8){
                    CircularProfileImageView(user: User.MOCK_USER, size: .xxSmall)
                    
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrrentUser: isFromCurrrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer()
                }
            }
        }.padding(.horizontal, 8)
    }
}

//#Preview {
  //  ChatMessageCell()
//}
