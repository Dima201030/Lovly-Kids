//
//  UserProfileView.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 07.06.2024.
//

import SwiftUI

struct UserProfileView: View {
    @State private var imageURL: URL?
    @State private var loadedImage: UIImage?
    @EnvironmentObject var viewModel: UserProfileViewModel
    @State private var firstNameLetter = ""
    @State private var sheetShowId = false
    var body: some View {
        ScrollView {
            VStack{
                if let loadedImage = loadedImage {
                    Image(uiImage: loadedImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.circle)
                        .frame(width: 120, height: 120)
                } else {
                    Circle()
                        .frame(width: 120, height: 120)
                        .foregroundColor(viewModel.userProfileColor)
                        .overlay(
                            Text(firstNameLetter)
                                .font(.system(size: 50, weight: .bold, design: .default))
                                .foregroundColor(.white)
                            
                        )
                }
                VStack {
                    Text("\(viewModel.userFullname)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(viewModel.userEmail)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Button {
                        
                    } label: {
                        VStack {
                            Image(systemName: "bell.slash.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Mute")
                        }
                        .frame(width: (UIScreen.main.bounds.width / 3) - 10, height: 70)
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    
                    Button {
                        
                    } label: {
                        VStack {
                            Image(systemName: "hand.raised.fill")
                                .resizable()
                                .frame(width: 20, height: 25)
                            Text("Block")
                        }
                        .frame(width: (UIScreen.main.bounds.width / 3) - 10, height: 70)
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    
                    Button {
                        sheetShowId.toggle()
                    } label: {
                        VStack {
                            //                                Image(systemName: "eye.fill")
                            //                                    .resizable()
                            //                                    .frame(width: 10, height: 10)
                            Text("Show id")
                        }
                        .frame(width: (UIScreen.main.bounds.width / 3) - 10, height: 70)
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .sheet(isPresented: $sheetShowId, content: {
                        Text("\(viewModel.userUid)")
                        
                        Button(action: {
                            // Call the copyToClipboard function and pass textToCopy as an argument to copy the text to the clipboard.
                            copyToClipboard(text: viewModel.userUid)
                        }) {
                            Text("Copy to Clipboard")
                        }
                        
                    })
                    
                    //                        VStack {
                    //                            Image(systemName: "phone")
                    //                            Text("Phone")
                    //                        }
                    //                        .background(Color(.systemGray5))
                    //                        .cornerRadius(10)
                    //                        .frame(width: (UIScreen.main.bounds.width / 4) - 20, height: 100)
                    //                        VStack {
                    //                            Image(systemName: "phone")
                    //                            Text("Phone")
                    //                        }
                    //                        .background(Color(.systemGray5))
                    //                        .cornerRadius(10)
                    //                        .frame(width: (UIScreen.main.bounds.width / 4) - 20, height: 100)
                    //                        VStack {
                    //                            Image(systemName: "phone")
                    //                            Text("Phone")
                    //                        }
                    //                        .background(Color(.systemGray5))
                    //                        .cornerRadius(10)
                    //                        .frame(width: (UIScreen.main.bounds.width / 4) - 4, height: 100)
                    //                        VStack {
                    //                            Image(systemName: "phone")
                    //                            Text("Phone")
                    //                        }
                    //                        .background(Color(.systemGray5))
                    //                        .cornerRadius(10)
                    //                        .frame(width: (UIScreen.main.bounds.width / 4) - 20, height: 100)
                }
                .padding( 4)
            }
            
            .onAppear() {
                
                firstNameLetter = String(viewModel.userFullname.prefix(1))
                
                
                imageURL = URL(string: viewModel.userProfileUrl)
                
                if let imageURL {
                    image(from: imageURL) { image in
                        loadedImage = image
                    }
                }
        }
        }
    }
    //        Text("\(viewModel.userFullname)")
    //        Text("\(viewModel.userAge)")
    //        Text("\(viewModel.userUid)")
    //        Text("\(viewModel.userProfileUrl)")
    //        Text("\(viewModel.userProfileColor)")
    
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
    func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
}

#Preview {
    UserProfileView()
}
