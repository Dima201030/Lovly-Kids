//
//  ProfileView15.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 14.06.2024.
//


import SwiftUI
import Firebase
import FirebaseStorage
import PhotosUI
import TipKit

//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) private var presentationMode
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.allowsEditing = true
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//        
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.editedImage] as? UIImage {
//                parent.image = image
//            } else if let image = info[.originalImage] as? UIImage {
//                parent.image = image
//            }
//            
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
//
//func image(from url: URL, completion: @escaping (UIImage?) -> Void) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        if let data, let image = UIImage(data: data) {
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        } else {
//            DispatchQueue.main.async {
//                completion(nil)
//            }
//        }
//    }
//    .resume()
//}
//@available(iOS 17.0, *)
//struct HintTipProfile: Tip {
//    var title: Text {
//        Text("Edit your profile for yourself")
//    }
//    
//    var message: Text? {
//        Text("In this tab, you can edit your profile for yourself. Everyone will see it.")
//    }
//    
//    var image: Image? {
//        Image(systemName: "person.text.rectangle")
//    }
//}

import SwiftUI

struct ProfileView15: View {
    
    @State private var isTipVisible = true
    @Environment(\.colorScheme) private var colorScheme
    @State private var firstNameLetter = ""
    let user: User
    @State private var showSheet = false
    @State private var image: UIImage?
    @State private var imageURL: URL?
    @State private var showingImagePicker = false
    @State private var loadedImage: UIImage?
    @State private var isPresent = false
    
    private let storage = Storage.storage()
    
    var body: some View {
            VStack {
                
                if let loadedImage {
                    
                    Image(uiImage: loadedImage)
                        .resizable()
                        .cornerRadius(15)
                        .scaledToFill()
                        .clipShape(.circle)
                        .frame(width: 120, height: 120)
                        .shadow(color: user.profileColor, radius: 30)
                        .offset(y: 30)
                    
                } else {
                    Circle()
                        .foregroundColor(user.profileColor)
                        .frame(width: 120, height: 120)
                        .shadow(color: user.profileColor, radius: 30)
                        .overlay(
                            Text(firstNameLetter)
                                .foregroundColor(.black)
                                .font(.title)
                        )
                        .offset(y: 30)
                    
                }
                    
                List {
                    Section {
                        HStack {
                            Spacer()
                            Button {
                                showingImagePicker = true
                            } label: {
                                Text("Select image")
                                    .multilineTextAlignment(.center)
//                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            }
                            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                                ImagePicker(image: $image)
                            }
                            Spacer()
                        }
                    }
                    Section {
                        Button {
                            showSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "person.text.rectangle")
                                
                                Text("Edit profile")
                            }
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                    Section {
                        Button(action: {AuthService.shared.singOut()}) {
                            Text("Log out")
                                .foregroundColor(.red)
                        }
                    }
                }
                .offset(y: 75)
            }
            
            .onAppear() {
                
                firstNameLetter = String(user.fullname.prefix(1))
                
                
                imageURL = URL(string: user.profileImageUrl)
                
                if let imageURL {
                    image(from: imageURL) { image in
                        loadedImage = image
                    }
                }
                if let imageURL = imageURL {
                    Task {
                        do {
                            try await saveDataOfUser(profileImageUrl: imageURL.absoluteString)
                            try await UserService.shared.fetchCurrentUser()
                        } catch {
                            print("Failed to save data: \(error)")
                        }
                    }

                    print("DEBUG: True \(user.profileImageUrl), \(imageURL.absoluteString)")
                }
            }
            .navigationTitle("Profile15")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSheet) {
                if #available(iOS 17, *) {
                    EditPrivaryInfo(user: user)
                        .environmentObject(AppData())
                } else {
                    // Fallback on earlier versions
                }
            
            
        }
    }
    
    func loadImage() {
        guard let selectedImage = image else { return }
        
        // Create a unique name for the image
        let imageName = UUID().uuidString
        
        // Reference to the folder in Storage where the image will be uploaded
        let imageRef = storage.reference().child("images/\(imageName).jpg")
        
        // Convert the image to JPEG and upload it to the server
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            imageRef.putData(imageData, metadata: nil) { _, error in
                if let error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                
                // Get the URL of the uploaded image
                imageRef.downloadURL { url, error in
                    if let error {
                        print("Error getting download URL: \(error.localizedDescription)")
                        return
                    }
                    
                    if let url {
                        self.imageURL = url
                        
                        if let imageURL {
                            image(from: imageURL) { image in
                                loadedImage = image
                            }
                        }
                    }
                }
            }
        }
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
    
    private func saveDataOfUser(profileImageUrl: String) async throws {
        do {
            try await AuthService.shared.changeUserData(email: user.email, fullname: user.fullname, id: user.uid!, age: user.age, profileColor: user.profileColorString, profileImageUrl: profileImageUrl)
            try await UserService.shared.fetchCurrentUser() // Обновление данных текущего пользователя
        } catch {
            print("Failed to save user data with error: \(error.localizedDescription)")
        }
    }
}
//#Preview {
//    ProfileView15()
//}
