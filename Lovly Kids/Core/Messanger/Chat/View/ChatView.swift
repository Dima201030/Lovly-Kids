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
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            ChatMessageView(message: message)
                                .id(message.id) // Убедитесь, что каждое сообщение имеет уникальный id
                        }
                    }
                    .padding(.bottom, 16)
                }
                .onChange(of: viewModel.messages) { _ in
                    scrollToBottom(scrollView)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        
                        TextField("Message...", text: $viewModel.messageText)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color(.gray))
                            .cornerRadius(20)
                            .padding(.bottom, keyboard.currentHeight)
                            .edgesIgnoringSafeArea(.bottom)
                            .animation(.easeOut(duration: 0.16))
                        Button(action: {
                            viewModel.sendMessage()
                            viewModel.messageText = ""
                        }, label: {
                            Text("Send")
                                .fontWeight(.semibold)
                        })
                        .padding(.trailing, 16)
                    }
                    
                
                }
                .frame(maxHeight: 150)
                .padding()
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
}
