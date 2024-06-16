//
//  ChatMessageView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 04.02.2024.
//

import SwiftUI

struct ChatMessageView: View {
    let message: Message
    @State private var imageURL: URL?
    @State private var loadedImage: UIImage?
    @State private var firstNameLetter = ""
    private var isFromCurrnetUser: Bool {
        return message.isFromCurrentUser
    }
    var body: some View {
        HStack {
            if isFromCurrnetUser {
                Spacer()
                
                HStack {
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                    
                    VStack {
                        Spacer()
                        
                        if message.read{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.green)
                                .shadow(color: .black, radius: 10)
                            
                        } else {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 10)
                        }
                    }
                    .padding()
                }
                .background(Color(.systemBlue))
                .clipShape(ChatBubble(isFromCurrentUser: isFromCurrnetUser))
                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    if let loadedImage = loadedImage {
                        Image(uiImage: loadedImage)
                            .resizable()
                            .cornerRadius(15)
                            .scaledToFill()
                            .clipShape(.circle)
                            .frame(width: 28, height: 28)
                    } else {
                        Circle()
                            .foregroundColor(message.user?.profileColor)
                            .frame(width: 28, height: 28)
                            .overlay(
                                Text(firstNameLetter)
                                    .foregroundColor(.black)
                            )
                    }
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrnetUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)

                    Spacer()
                    
                    
                }
            }
        }
        .onAppear() {
            if let fullname = message.user?.fullname, !fullname.isEmpty {
                firstNameLetter = String(fullname.prefix(1))
            }
            
            imageURL = URL(string: message.user?.profileImageUrl ?? "")
            
            if let imageURL {
                image(from: imageURL) { image in
                    loadedImage = image
                }
            }
        }
        .padding(.horizontal, 8)
    }
    func image(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        .resume()
    }
}
//
//#Preview {
//    ChatMessageView(message: false)
//}
