import SwiftUI

struct InboxView: View {
    @State private var showMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    
    // Navigation path for stack
    @State private var path = NavigationPath()
    
    private var user: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                // ✅ Active Now Section
                Section {
                    ActiveNowView()
                        .padding(.vertical)
                        .padding(.horizontal, 4)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }
                
                // ✅ Recent Messages Section
                Section {
                    ForEach(viewModel.recentMessages) { message in
                        NavigationLink(value: Route.chatView(message.user!)) {
                            InboxRowView(message: message)
                        }
                        .buttonStyle(.plain) // 👈 removes system chevron + blue highlight
                    }
                }
            }
            .listStyle(.plain)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                case .chatView(let user):
                    ChatView(user: user)
                }
            }
            .onChange(of: selectedUser) { newValue in
                if let user = newValue {
                    showMessageView = false
                    path.append(Route.chatView(user))
                }
            }
            .fullScreenCover(isPresented: $showMessageView) {
                NewMessageView(selectedUser: $selectedUser)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                CircularProfileImageView(user: user, size: .xsmall)
                            }
                        }
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray6))
                    }
                }
            }
        }
    }
}
