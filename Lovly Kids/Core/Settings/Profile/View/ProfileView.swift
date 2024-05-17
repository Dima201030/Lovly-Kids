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
    let user: User
    @StateObject var profileViewModel = ProfileViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var showSheet = false
    @State private var image: UIImage?
    @State private var imageURL: URL?
    @State private var showingImagePicker = false
    @State private var loadedImage: UIImage?
    private let storage = Storage.storage()
    @State private var isPresent = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if user.profileImageUrl == "" {
                    
                } else {
                    Button {
                        self.showingImagePicker = true
                    } label: {
                        Image(systemName: "person.circle")
                    }
                    .padding()
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$image)
                    }
                }
                
                if let loadedImage = loadedImage {
                    Image(uiImage: loadedImage)
                        .resizable()
                        .cornerRadius(15)
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                        .shadow(color: colorScheme == .dark ? (profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.white : Color.black)) : Color.white, radius: 30) // Use average color in shadow
                } else {
                    Text("Image not loaded")
                }
                
                //                Button("Load Image") {
                //                    if let url = user.profileImageUrl {
                //                        image(from: URL(string: url)!) { loadedImage in // Cannot call value of non-function type 'UIImage?'
                //                            guard let image = loadedImage else { return }
                //                            print("DEBUG", image)
                //                            self.loadedImage = image // Cannot assign value of type '_' to type 'UIImage?'
                //                        }
                //                    }
                //                }
                
                
                
                if let imageURL = imageURL {
                    Text("Image URL: \(imageURL.absoluteString)")
                        .padding()
                }
                
                List {
                    Section {
                        Button {
                            showSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "person.text.rectangle")
                                Text("Edit main data")
                            }
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
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
            .onChange(of: imageURL) { newValue in
                if let newURL = newValue {
                    Task { try await saveDataOfUser(profileImageUrl: newURL.absoluteString)
                        try await UserService.shared.fetchCurrentUser() }
                    print("DEBUG: TRue \(user.profileImageUrl), \(newURL.absoluteString)")
                    if let url = user.profileImageUrl {
                        image(from: URL(string: url)!) { loadedImage in // Cannot call value of non-function type 'UIImage?'
                            guard let image = loadedImage {
                            print("DEBUG", image)
                            loadedImage = image // Cannot assign value of type '_' to type 'UIImage?'
                        }
                    }
                    
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSheet, content: {
                EditPrivaryInfo(user: user)
                    .environmentObject(AppData())
            })
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
            imageRef.putData(imageData, metadata: nil) { (_, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                
                // Get the URL of the uploaded image
                imageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                        return
                    }
                    
                    if let url = url {
                        self.imageURL = url
                    }
                }
            }
        }
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
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
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


#Preview {
    ProfileView(user: User.MOCK_USER)
        .environmentObject(AppData())
    
}
