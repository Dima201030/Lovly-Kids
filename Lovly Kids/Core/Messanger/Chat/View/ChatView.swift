//
//  ChatView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 03.02.2024.
//

import SwiftUI
import Combine

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    @ObservedObject private var keyboard = KeyboardResponder()
    
    @State private var textFieldInput = ""
    
    let user: User
    let onDisappear: (() -> Void)?
    
    init(user: User, onDisappear: (() -> Void)? = nil) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
        self.onDisappear = onDisappear
    }
    
    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            ChatMessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.bottom, 16)
                }
                
                Spacer()
                
                HStack {
                    TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                        .padding(12)
                        .padding(.trailing, 48)
                        .background(Color(.systemGroupedBackground))
                        .font(.subheadline)
                        .cornerRadius(20)
                    
                    Button {
                        viewModel.sendMessage()
                        viewModel.messageText = ""
                    } label: {
                        VStack {
                            Text("Send")
                                .foregroundColor(.black)
                                .font(.subheadline)
                                .padding(5)
                        }
                        .background(.pink)
                        .cornerRadius(5)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarTitle(user.fullname, displayMode: .inline)
        }
        .onDisappear {
            onDisappear?()
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
    @Published private(set) var currentHeight = 0.0
    
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
}
