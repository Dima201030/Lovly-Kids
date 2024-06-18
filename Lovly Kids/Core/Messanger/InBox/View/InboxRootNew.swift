//
//  InboxRootNew.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct InboxRootNew: View {
    @State private var imageURL: URL?
    @State private var loadedImage: UIImage?
    @State private var firstNameLetter = ""
    @State private var text = ""
    let message: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let loadedImage = loadedImage {
                Image(uiImage: loadedImage)
                    .resizable()
                    .cornerRadius(15)
                    .scaledToFill()
                    .clipShape(.circle)
                    .frame(width: 56, height: 56)
            } else {
                Circle()
                    .foregroundColor(message.user?.profileColor)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Text(firstNameLetter)
                            .foregroundColor(.black)
                            .font(.title)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullname ?? "")
                    .lineLimit(1)
                    .font(.subheadline)
//                    .fontWeight(.semibold)
                
                Text(text)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            HStack {
                Text(message.timestampString)
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .onAppear {
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
        }
        .frame(height: 72)
        .onAppear {
            text = decrypt(text: message.messageText, with: 3)
        }
    }
    
    func decrypt(text: String, with key: Int) -> String {
        String(text.unicodeScalars.map {
            Character(UnicodeScalar(UInt32($0.value) - UInt32(key))!)
        })
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

//#Preview {
//    InboxRootNew()
//}
