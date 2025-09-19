//
//  ChatBubble.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 10/09/2025.
//

import SwiftUI

struct ChatBubble: Shape {
    let isFromCurrrentUser: Bool
    
    func path(in rect: CGRect)-> Path {
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topRight, .topLeft,
                                    isFromCurrrentUser ? .bottomLeft: .bottomRight ],
                                cornerRadii: CGSize(width   : 16, height: 16))
        
        return Path(path.cgPath)
    }
}

#Preview {
    ChatBubble(isFromCurrrentUser: true)
}
