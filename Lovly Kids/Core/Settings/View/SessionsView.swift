//
//  SessionsView.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 02.06.2024.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

struct SessionsView: View {
    @StateObject private var viewModel = SessionsViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.sessions) { session in
                HStack {
                    VStack(alignment: .leading) {
                        Text("IP: \(session.ip)")
                        Text("Date: \(session.date, formatter: dateFormatter)")
                        Text("Time: \(session.time, formatter: timeFormatter)")
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.toggleBlocked(sessionId: session.id ?? "")
                    } label: {
                        Text(session.blocked ? "Unblock" : "Block")
                            .foregroundColor(.white)
                            .padding()
                            .background(session.blocked ? .red : .green)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .navigationTitle("Sessions")
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    SessionsView()
}

struct Session: Identifiable, Codable {
    @DocumentID var id: String? // идентификатор сеанса
    var date: Date
    var ip: String
    var time: Date
    var blocked: Bool
}

class SessionsViewModel: ObservableObject {
    @Published var sessions = [Session]()
    private var userSession: FirebaseAuth.User?
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.userSession = Auth.auth().currentUser
        fetchSessions()
    }
    
    func fetchSessions() {
        guard let userId = userSession?.uid else { return }
        
        db.collection("users").document(userId).collection("sessions").addSnapshotListener { querySnapshot, error in
            if let error {
                print("DEBUG: Error fetching sessions: \(error.localizedDescription)")
                return
            }
            
            self.sessions = querySnapshot?.documents.compactMap { document -> Session? in
                try? document.data(as: Session.self)
            } ?? []
        }
    }
    
    func toggleBlocked(sessionId: String) {
        guard let userId = userSession?.uid else { return }
        
        let sessionRef = db.collection("users").document(userId).collection("sessions").document(sessionId)
        
        sessionRef.getDocument { document, error in
            if let error {
                print("DEBUG: Error getting session: \(error.localizedDescription)")
                return
            }
            
            guard var session = try? document?.data(as: Session.self) else { return }
            
            session.blocked.toggle()
            
            do {
                try sessionRef.setData(from: session)
            } catch {
                print("DEBUG: Error updating session: \(error.localizedDescription)")
            }
        }
    }
}
