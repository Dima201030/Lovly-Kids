//
//  NewMessageView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessangeViewModel()
    @Binding var selectedUser: User?
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                Text("CONTACTS")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(viewModel.users) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .xSmall)
                            
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancle") {
                        dismiss()
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    NewMessageView(selectedUser: .constant(User.MOCK_USER))
        .environmentObject(AppData())
        
}
