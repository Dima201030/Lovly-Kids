//
//  NewMessageView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct NewMessageView: View {
    @StateObject private var viewModel = NewMessangeViewModel()
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    @Binding var selectedUser: User?
    
    var body: some View {
        
        ScrollView {
            
            // SEARCH FIELD
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search…", text: $searchText)
                    .autocorrectionDisabled()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top, 8)
            
            // CONTACTS TITLE
            Text("CONTACTS")
                .foregroundColor(.gray)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 12)
            
            // CONTACT LIST
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.users) { user in
                    HStack(spacing: 12) {
                        CircularProfileImageView(user: user, size: .xSmall)
                        
                        Text(user.fullname)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                    
                    Divider()
                        .padding(.leading, 60)
                }
            }
            .padding(.top, 4)
        }
        .navigationTitle("New Message")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                        
                        Text("Back")
                            .font(.headline)
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    NewMessageView(selectedUser: .constant(User.MOCK_USER))
        .environmentObject(AppData())
    
}
