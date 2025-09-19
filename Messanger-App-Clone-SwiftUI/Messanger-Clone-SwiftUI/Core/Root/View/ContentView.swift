//
//  ContentView.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 09/09/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group{
            if viewModel.userSession !=  nil {
                //AuthService.shared.signOut()
                InboxView()
            }
            else{
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
