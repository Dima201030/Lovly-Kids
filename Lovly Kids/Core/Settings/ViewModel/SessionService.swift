////
////  Ы.swift
////  Lovely Kids
////
////  Created by Дима Кожемякин on 02.06.2024.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//
//class SessionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    @IBOutlet weak var tableView: UITableView!
//    var sessions: [Session] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        fetchSessions()
//    }
//
//    func fetchSessions() {
//        let db = Firestore.firestore()
//        let userUID = "qJYK4Ob7JlU8dW0D8P4qO6ABwaq1"
//        db.collection("sessions").whereField("userUID", isEqualTo: userUID).getDocuments { (querySnapshot, error) in
//            if let error {
//                print("Error getting documents: \(error)")
//            } else {
//                self.sessions = querySnapshot?.documents.compactMap { document in
//                    try? document.data(as: Session.self)
//                } ?? []
//                print("Fetched \(self.sessions.count) sessions")
//                self.tableView.reloadData()  // Обновление интерфейса после получения данных
//            }
//        }
//    }
//
//    // MARK: - UITableViewDataSource
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        sessions.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath)
//        let session = sessions[indexPath.row]
//        cell.textLabel?.text = session.name
//        return cell
//    }
//}
//
//// Модель данных для сессий
//struct Session: Codable {
//    var name: String
//    var userUID: String
//}
