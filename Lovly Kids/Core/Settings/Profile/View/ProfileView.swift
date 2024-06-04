//
//  ProfileView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import Firebase
import FirebaseStorage
import PhotosUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    let user: User
    
    @State private var showSheet = false
    @State private var image: UIImage?
    @State private var imageURL: URL?
    @State private var showingImagePicker = false
    @State private var loadedImage: UIImage?
    @State private var isPresent = false
    
    private let storage = Storage.storage()
    
    var body: some View {
        NavigationStack {
            VStack {
                if user.profileImageUrl != "" {
                    
                } else {
                    Button {
                        showingImagePicker = true
                    } label: {
                        Image(systemName: "person.circle")
                    }
                    .padding()
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $image)
                    }
                }
                
                if let loadedImage {
                    Button {
                        showingImagePicker = true
                    } label: {
                        Image(uiImage: loadedImage)
                            .resizable()
                            .cornerRadius(15)
                            .scaledToFill()
                            .clipShape(.circle)
                            .frame(width: 120, height: 120)
                            .shadow(color: colorScheme == .dark ? (profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? .white : .black)) : .white, radius: 30) // Use average color in shadow
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $image)
                    }
                } else {
                    Button {
                        showingImagePicker = true
                    } label: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .cornerRadius(15)
                            .scaledToFill()
                            .clipShape(.circle)
                            .frame(width: 120, height: 120)
                            .shadow(color: colorScheme == .dark ? (profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? .white : .black)) : .white, radius: 30) // Use average color in shadow
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $image)
                    }
                }
                
                List {
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
                .offset(y: 25)
            }
            .onChange(of: imageURL) { _, newValue in
                if let newValue {
                    Task {
                        try await saveDataOfUser(profileImageUrl: newValue.absoluteString)
                        try await UserService.shared.fetchCurrentUser()
                    }
                    
                    print("DEBUG: TRue \(user.profileImageUrl), \(newValue.absoluteString)")
                }
            }
            .onAppear() {
                imageURL = URL(string: user.profileImageUrl)
                
                if let imageURL {
                    image(from: imageURL) { image in
                        loadedImage = image
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSheet) {
                EditPrivaryInfo(user: user)
                    .environmentObject(AppData())
//                    .environment(\.colorScheme, .light)
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


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.editedImage] as? UIImage {
                parent.image = image
            } else if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
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
