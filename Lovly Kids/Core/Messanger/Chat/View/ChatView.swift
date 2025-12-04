//
//  ChatView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 03.02.2024.
//

import SwiftUI
import Combine

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @ObservedObject private var keyboard = KeyboardResponder()
    @State private var textFieldInput: String = ""
    let user: User
    @EnvironmentObject private var viewModelUserProfile: UserProfileViewModel
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                ScrollView {
                    VStack(spacing: 8) {
                        NavigationLink {
                            UserProfileView()
                        } label: {
                            Text("Profile")
                        }
                        
                        ForEach(viewModel.messages) { message in
                            ChatMessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.bottom, 16)
                }
                .onChange(of: viewModel.messages) { _ in
                    scrollToBottom(scrollView)
                }
                
                ZStack(alignment: .trailing) {
                    if #available(iOS 16.0, *) {
                        TextField("Message..." , text: $viewModel.messageText, axis: .vertical)
                            .padding(12)
                            .padding(.trailing, 48)
                            .background(Color(.systemGroupedBackground))
                            .cornerRadius(15)
                            .font(.subheadline)
                    }
                    
                    Button {
                        viewModel.sendMessage()
                        viewModel.messageText = ""
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    .padding(.horizontal)
                    
                }
                .padding()
            }
            .onAppear {
                viewModelUserProfile.userFullname = user.fullname
                viewModelUserProfile.userUid = user.uid ?? ""
                viewModelUserProfile.userProfileUrl = user.profileImageUrl
                viewModelUserProfile.userProfileColor = user.profileColor
                viewModelUserProfile.userAge = user.age
                
            }
            .navigationBarTitle(user.fullname, displayMode: .inline)
        }
    }
    
    private func scrollToBottom(_ scrollView: ScrollViewProxy) {
        DispatchQueue.main.async {
            scrollView.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
        }
    }
}

final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
        .environmentObject(UserProfileViewModel())
}
